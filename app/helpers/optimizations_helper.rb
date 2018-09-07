module OptimizationsHelper

  def putoptdata(optid)

    @optimization = Optimization.find(optid)
    opttype = @optimization.optimizationtype
    @orders = Order.where(optimization: optid)

    @standardemissions = Option.find_by_name("standardemissions").value.to_f
    @realtotalemission = 0
    @realtotaldistance = 0
    @totaldistance = 0
    @totalroutedistance = 0
    @totaltime = 0
    @totalturnover = 0
    @productscount = 0
    @worktimecosts = 0
    @drivingcosts = 0
    @boxes = 0
    @coolingboxes = 0
    @freezingboxes = 0
    @emission = 0
    @orderscount = []
    @allocation = []


    <<-DOC
      @totaldistance = @optimization.totaldistance.presence || 0
      @totaltime = @optimization.totaltraveltime.presence || 0
      @totalturnover = @optimization.turnover.presence || 0
      @productscount = 0
      @worktimecosts = @optimization.worktimecosts.presence || 0
      @drivingcosts = @optimization.drivingcosts.presence || 0
      @boxes = @optimization.totalboxes.presence || 0
      @coolingboxes = @optimization.totalcoolingboxes.presence || 0
      @freezingboxes = @optimization.totalfreezingboxes.presence || 0
      @emission = @optimization.emissions.presence || 0
      @orderscount = []
      @allocation = []
DOC



    # Distanzen summieren bei Home-Delivery

    if opttype == 3 or opttype == 1
    @routes = Route.where(optimization_id: optid)
      @routes.each do |route|
        @totaldistance += route.traveldistance
        @totalroutedistance += route.traveldistance
        @totaltime += route.traveltime
        @emission += route.emissions
        @worktimecosts += route.worktimecosts
        @drivingcosts += route.drivingcosts
        @boxes += route.boxes
        @coolingboxes += route.coolingboxes
        @freezingboxes += route.freezingboxes

        @realtotaldistance += route.traveldistance
        @realtotalemission += route.emissions


        orderslist = route.route.split("->")
        orderslist.each do |order|

          order = Order.find(order.to_i)
          # Jetzt noch die Distanz zwischen Arbeit und dem zu Hause berechnen um die real distance zu haben
          mydistancefromhometowork= Distance.find_by_from_id_and_to_id_and_typey(order.customer_id, order.customer_id, 5)
          @realtotaldistance += mydistancefromhometowork.traveldistance
          @realtotalemission += mydistancefromhometowork.traveldistance * @standardemissions


        end

      end
    end

    # Distanzen summieren bei Pick-Up

    @orders.each do |order|
      # Zunächst die Distanzen hinzufügen pro Bestellung bei Pick-Ups
      store = order.allocatedstore
      if opttype == 4 or opttype == 1
      mydistancetostore = Distance.find_by_from_id_and_to_id_and_typey(order.customer_id, store, 4)
      mydistancetohome = Distance.find_by_from_id_and_to_id_and_typey(store, order.customer_id, 2)

      distance = mydistancetostore.traveldistance + mydistancetohome.traveldistance
      time = mydistancetostore.traveltime + mydistancetohome.traveltime
      @totaldistance += distance
      @totaltime += time

        @realtotaldistance += distance
      # Jetzt noch die Distanz zwischen Arbeit und dem zu Hause berechnen um die real distance zu haben
     # mydistancefromhometowork= Distance.find_by_from_id_and_to_id_and_typey(order.customer_id, order.customer_id, 5)
     # @realtotaldistance += mydistancetostore.traveldistance + mydistancetohome.traveldistance + mydistancefromhometowork.traveldistance


      elsif opttype == 2 or opttype == 1
        mydistancetostore = Distance.find_by_from_id_and_to_id_and_typey(order.customer_id, store, 3)
        mydistancetohome = Distance.find_by_from_id_and_to_id_and_typey(store, order.customer_id, 2)

        distance = mydistancetostore.traveldistance + mydistancetohome.traveldistance
        time = mydistancetostore.traveltime + mydistancetohome.traveltime
        @totaldistance += distance
        @totaltime += time


          # Jetzt noch die Distanz zwischen Arbeit und dem zu Hause berechnen um die real distance zu haben
        mydistancefromhometowork= Distance.find_by_from_id_and_to_id_and_typey(order.customer_id, order.customer_id, 5)
        @realtotaldistance += mydistancetostore.traveldistance + mydistancetohome.traveldistance + mydistancefromhometowork.traveldistance


      end

      # Dann die Bestellung in den Allocation String mit der entsprechenden Zuordnung packen

      forallocation = order.id.to_s + "-" + order.allocatedstore.to_s
      @allocation.push(forallocation)


      # Dann die Produkteinnahmen hinzufügen
      @totalturnover += order.price

      # Dann die Anzahl der Produkte zum Zähler hinzufügen
      products = order.products.split(",")
      products.each do |prod|
        pp = prod.split("-")
        @productscount += pp[1].to_f

      end

      # Jede Bestellung in der orderscount Array pushen um am Ende einen String davon zu haben
      @orderscount.push(order.id)

    end

    @optimization.totaldistance = @totaldistance
    @optimization.totaltraveltime = @totaltime
    @optimization.realtotaldistance = @realtotaldistance
    @optimization.realtotalemissions = @realtotalemission


    # Jetzt werden die Kosten berechnet

    @timeperproduct = Option.find_by_name("timeperproduct").value.to_f / 60 / 60  # = Sekunden zu Stunden, damit dies mit dem Stundenkostensatz verrechnet werden kann
    @hourscost = Option.find_by_name("hourcosts").value.to_f
    @costsperkm = Option.find_by_name("drivingcosts").value.to_f
    @cartcosts = Option.find_by_name("cartcosts").value.to_f

    if opttype == 3 or opttype == 1
    @optimization.worktimecosts = @worktimecosts + @productscount * ( @timeperproduct * @hourscost ) #
    @optimization.drivingcosts = @drivingcosts
    @optimization.profit = @totalturnover * (1 - @cartcosts) - @drivingcosts - ( @worktimecosts + @productscount * ( @timeperproduct * @hourscost ) )
    # Bei "Wie gewünscht" die genauen Touren-Emissionen und Standardemissionen bei Pick-Up trennen
    if opttype == 1
      @optimization.emissions = @emission + (@totaldistance - @totalroutedistance) * @standardemissions
      # Außerdem die Allokation noch hinzufügen
      @optimization.allocation = @allocation.join(",")
    else
      @optimization.emissions = @emission
    end

    @optimization.totalcoolingboxes = @coolingboxes
    @optimization.totalfreezingboxes = @freezingboxes
    @optimization.totalboxes = @boxes



    elsif opttype == 2 or opttype == 4
      @optimization.worktimecosts = @productscount * ( @timeperproduct * @hourscost )
      @optimization.drivingcosts = 0
      @optimization.emissions = @totaldistance * @standardemissions
      @optimization.profit = @totalturnover * (1 - @cartcosts) - @productscount * ( @timeperproduct * @hourscost )
      @optimization.allocation = @allocation.join(",")

      @realtotalemission = @realtotaldistance * @standardemissions
      @optimization.realtotalemissions = @realtotalemission

    end

    @optimization.orderslist = @orderscount.join(",")
    @optimization.turnover = @totalturnover
    @optimization.productcosts = @totalturnover * @cartcosts
    @optimization.save
  end





def checkstocks(st,od,optid,mystatus)

  if Optimization.find(optid).optimizationtype != 1

  if st == 1
    @stores = Store.where(concept: 1)
  elsif st == 2
    @stores = Store.where(concept: 2)
  elsif st == 3
    @stores = Store.where(concept: 3)
  elsif st == 4
    @stores = Store.where(concept: 4)
  elsif st == 5
    @stores = Store.where(concept: 5)
  elsif st == 12
    @stores = Store.where(:concept => [1,2])
  elsif st == 245
    @stores = Store.where(:concept => [2,4,5])
  else
    if Optimization.find(optid).optimizationtype == 2 or Optimization.find(optid).optimizationtype == 4
      @stores = Store.where(:concept => [1,2,3])
      end
  end

  # Status lesen
  if mystatus == 1
    @mystatus = [1]
  elsif mystatus == 2
    @mystatus = [2]
  elsif mystatus == 12
    @mystatus = [1, 2]
  end

  # Bestellungen
  # allocationmethod 1 = Home-Pick-Up, 2 = Work-Pick-Up

  if od == 1
    @orders = Order.where(allocationmethod: 1, :status => @mystatus)
  elsif od == 12
    @orders = Order.where(:allocationmethod => [1, 2], :status => @mystatus)
  elsif od == 2
    @orders = Order.where(allocationmethod: 2, :status => @mystatus)
  elsif od == 3
    @orders = Order.where(allocationmethod: 3, :status => @mystatus)
  else
    @orders = Order.where(:status => @mystatus)
  end

  else

    # Wenn "Wie geschwünst" werden die Bestellungen und Geschäfte vorher bestimmt
    @orders = od
    @stores = st

  end



  # Zunächst wird die Include Datei aufgebaut

  if File.exist?("capacityinclude.inc")
    File.delete("capacityinclude.inc")
  end

  # INCLUDE DATEI AUFBAUEN  -------------------------

  f=File.new("capacityinclude.inc", "w")

  # SETS

  printf(f, "set g / \n")
  @stores.each do |store|
    printf(f, "Store-" + store.id.to_s + "\n")
  end
  printf(f, "/" + "\n\n")

  printf(f, "p / \n")
  Product.all.each do |product|
    printf(f, "Product-" + product.id.to_s + "\n")
  end
  printf(f, "/" + "\n\n")

  printf(f, "b / \n")
  @orders.each do |order|
    printf(f, "Order-" + order.id.to_s + "\n")
  end
  printf(f, "/;" + "\n\n")


  # PARAMETER

  # Gewünschte Produkte in den Bestellungen

  printf(f, "Parameter\n  o(b,p) /\n")

  @orders.each do |order|

    @products = order.products.split(",")
    @products.each do |product|

      productid = product.split("-")[0]
      printf(f, "Order-" + order.id.to_s + "." + "Product-" + productid + "        1" + "\n")

    end
  end

  printf(f, "/" + "\n\n")


  printf(f, "Parameter\n  s(g,p) /\n")

  @stores.each do |store|

    @stocks = Stock.where(store_id: store.id, stock: true)
    @stocks.each do |stock|

      printf(f, "Store-" + store.id.to_s + "." + "Product-" + stock.product_id.to_s + "        1" + "\n")

    end
  end

  printf(f, "/ ;" + "\n\n")


  f.close

  # INCLUDE DATEI FERTIG

  # Das GAMS Modell starten

  gamspath = Option.find_by_name("gamspath").value
  system gamspath + " capacitymodell"



  ############# SOLUTION ################

  # Ergebnisse (Mögliche Geschäft in die Bestellung eintragen)

  # Zuerst mögliche alte possiblestores entfernen
  @orders.each do |order|
    order.possiblestores = nil
    order.save
  end

  if (File.exist?("capasolution.txt"))

    fil=File.open("capasolution.txt", "r")

    fil.each { |line| # printf(f,line)
      sa = line.split(" ; ")
      order = sa[1].delete " \n"    # Bestellung
      store = sa[0].delete " \n"    # Geschäft

      orderid = order.split("-")[1]
      storeid = store.split("-")[1]

      myorder = Order.find(orderid)
      possiblestores = myorder.possiblestores

      if possiblestores != nil

        storesarray = possiblestores.split(",")
        storesarray.push(storeid)

      else

        storesarray = []
        storesarray.push(storeid)

      end

      myorder.possiblestores = storesarray.join(",")
      myorder.save


    }


    fil.close

  else
    # Wenn keine solution.txt Datei vorhanden ist
    flash.now[:danger] = "Fehler bei der Berechenung der Verfügbarkeiten!"

  end




end

end

