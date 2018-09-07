module PickuphomeHelper



  def startpickuphome(st,od,optid,mystatus)

    # Die Art der Optimierung festsetzen: Welche Geschäfte und welche Bestellungen werden verwendet?

    if Optimization.find(optid).optimizationtype != 1

      # Geschäfte
    # concept 1 = Geschäft, 2 = Pick-Up Station, 3 = Central Pick-Up Station

    if st == 1
      @stores = Store.where(concept: 1)
    elsif st == 2
      @stores = Store.where(concept: 2)
    elsif st == 3
      @stores = Store.where(concept: 3)
    elsif st == 12
      @stores = Store.where(:concept => [1,2])
    else
      @stores = Store.where(:concept => [1,2,3])
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
    else
      @orders = Order.where(:status => @mystatus)
    end

    else

      # Wenn "Wie geschwünst" werden die Bestellungen und Geschäfte vorher bestimmt
      @orders = od
      @stores = st

    end

    $noorders = false
    if @orders.empty? or @stores.empty?
      flash[:danger] = "Deine Auswahl ist nicht berechenbar, da es dafür keine Bestellungen oder Geschäfte gibt."
      $noorders = true
    else


    # Zunächst wird die Include Datei aufgebaut

    if File.exist?("include2.inc")
      File.delete("include2.inc")
    end

    # INCLUDE DATEI AUFBAUEN  -------------------------

    f=File.new("include2.inc", "w")

    # SETS


    printf(f, "set g / \n")
    @stores.each do |store|
    printf(f, "Store-" + store.id.to_s + "\n")
    end
    printf(f, "/" + "\n\n")


    printf(f, "k / \n")
    @orders.each do |order|
      printf(f, "Order-" + order.id.to_s + "\n")
    end
    printf(f, "/;" + "\n\n")


    # PARAMETER

    # Fahrtzeiten zwischen Kunden und Geschäften

    printf(f, "Parameter\n  fz(k,g) /\n")

    @orders.each do |order|
      @stores.each do |store|
        distance = Distance.find_by_typey_and_from_id_and_to_id(3, Customer.find(order.customer_id).id, store.id)

        printf(f, "Order-" + order.id.to_s + "." + "Store-" + store.id.to_s + "        " + distance.traveltime.to_s + "\n")

      end

    end

    printf(f, "/" + "\n\n")


    # Verfügbarkeiten von Geschäften für die Bestellungen

    printf(f, "Parameter\n  z(k,g) /\n")

    @orders.each do |order|
      stores = order.reload.possiblestores.split(",")

      stores.each do |store|

        printf(f, "Order-" + order.id.to_s + "." + "Store-" + store + "        1" + "\n")

      end

    end

    printf(f, "/" + "\n\n")


    f.close

    # INCLUDE DATEI FERTIG

    # Das GAMS Modell starten

    gamspath = Option.find_by_name("gamspath").value
    system gamspath + " modell2"



    ############# SOLUTION ################

    # Ergebnisse (Zugeordnetes Geschäft in die Bestellung eintragen)

    if (File.exist?("solution2.txt"))

      fil=File.open("solution2.txt", "r")

      fil.each { |line| # printf(f,line)
        sa = line.split(" ; ")
        order = sa[0].delete " \n"    # Nanny-Name
        store = sa[1].delete " \n"    # Kundenname + Auftrags-ID

        orderid = order.split("-")[1]
        storeid = store.split("-")[1]

        myorder = Order.find(orderid)
        myorder.allocatedstore = storeid
        myorder.save


      }


      fil.close

    else
      # Wenn keine solution.txt Datei vorhanden ist
      #flash.now[:success] = "Noch kein Ergebniss berechnet!"

    end

    # In alle Bestellungen die aktuelle Optimierung eintragen
    @orders.each do |order|
      order.optimization = optid
      order.status = 2
      order.save
    end


  end




end


end
