module HomedeliveryHelper



  def starthomedelivery(st,od,optid,mystatus)


    # SCHICHTBEGINN UND ENDE
    timewindows = Option.find_by_name("timewindows").value
    twar = timewindows.split(",")
    twar.first

    @shiftbegin = twar.first.split("-")[0]
    @shiftend = twar.last.split("-")[1]


    if Optimization.find(optid).optimizationtype != 1

            # Status lesen
            if mystatus == 1
              @mystatus = [1]
            elsif mystatus == 2
              @mystatus = [2]
            elsif mystatus == 12
              @mystatus = [1, 2]
            end

            # Die Art der Optimierung festsetzen: Welche Geschäfte und welche Bestellungen werden verwendet?

            # Geschäfte
            # concept 2 = Geschäft mit Home-Delivery, 4 = Warehouse, 5 = Hub

            if st == 2
              @stores = Store.where(concept: 2)
            elsif st == 4
              @stores = Store.where(concept: 4)
            elsif st == 5
              @stores = Store.where(concept: 5)
            elsif st == 245
              @stores = Store.where(:concept => [2,4,5])
            end

            # Geschäfte löschen, die keine Fahrer haben
            @newstores = []
            @stores.each do |store|
              existingdrivers = Driver.where(store_id: store.id)
              if existingdrivers.empty?
              else
                @newstores.push(store)
              end
            end

            @stores = @newstores

            # Bestellungen
            # allocationmethod 1 = Home-Pick-Up, 2 = Work-Pick-Up, 3 = Home-Delivery

            if od == 12
              @orders = Order.where(:allocationmethod => [1, 2], :status => @mystatus)
            elsif od == 3
              @orders = Order.where(allocationmethod: 3, :status => @mystatus)
            else
              @orders = Order.where(:status => @mystatus)
            end

    else

      # Wenn "Wie geschwünst" werden die Bestellungen und Geschäfte vorher bestimmt
      @orders = od
      @stores = st

      # Geschäfte löschen, die keine Fahrer haben
      @newstores = []
      @stores.each do |store|
        existingdrivers = Driver.where(store_id: store.id)
        if existingdrivers.empty?
        else
          @newstores.push(store)
        end
      end

      @stores = @newstores

    end

    $noorders = false

    # Prüfen ob alle Geschäfte Fahrer haben

    if @orders.empty? or @stores.empty?
      flash[:danger] = "Deine Auswahl ist nicht berechenbar, da es dafür keine Bestellungen, Geschäfte oder Fahrer gibt."
      $noorders = true
    else

    # Fahrer
    @drivers = []
    @stores.each do |store|
      mydrivers = Driver.where(store_id: store.id)
      mydrivers.each do |myd|
        @drivers.push(myd)

      end


    end






    # Zunächst wird die Include Datei aufgebaut

    if File.exist?("homedelivery.inc")
      File.delete("homedelivery.inc")
    end

    # INCLUDE DATEI AUFBAUEN  -------------------------

    f=File.new("homedelivery.inc", "w")

    # SETS


    printf(f, "set i / \n")
    @drivers.each do |d|
    printf(f, "Driver-" + d.id.to_s + "\n")
    end
    @orders.each do |o|
      printf(f, "Order-" + o.id.to_s + "\n")
    end
    printf(f, "/" + "\n\n")

    printf(f, "h / \n")
    @drivers.each do |d|
      printf(f, "Driver-" + d.id.to_s + "\n")
    end
    printf(f, "/" + "\n\n")

    printf(f, "p / \n")
      printf(f, "box"+ "\n")
    printf(f, "cbox"+ "\n")
    printf(f, "fbox"+ "\n")

    printf(f, "/;" + "\n\n")


    # PARAMETER

    # Anzahl der Fahrer

    printf(f, "Parameter\n  fahrerzahl /\n")

      printf(f, @drivers.count.to_s + "\n")

    printf(f, "/" + "\n\n")

    # Kundenanfang

    printf(f, "Parameter\n  kundenanfang /\n")

    printf(f, (@drivers.count + 1).to_s + "\n")

    printf(f, "/" + "\n\n")



    # Reichweiten der Fahrzeuge der Fahrer

    printf(f, "Parameter\n  rw(h) /\n")

    @drivers.each do |d|

      printf(f, "Driver-" + d.id.to_s + "        " + Vehicle.find(d.vehicle_id).range.to_s + "\n")

    end

    printf(f, "/" + "\n\n")


    # Geschwindigkeit des Fahrzeugs der Fahrer

    printf(f, "Parameter\n  kmmin(h) /\n")


    @drivers.each do |d|

      printf(f, "Driver-" + d.id.to_s + "        " + Vehicle.find(d.vehicle_id).speed.to_s + "\n")

    end

    printf(f, "/" + "\n\n")

    # Verfügbarkeiten von Geschäften für die Bestellungen

    printf(f, "Parameter\n  po(i,h) /\n")

    @orders.each do |order|
      stores = order.reload.possiblestores.split(",")

      @drivers.each do |driver|

        storeid = Store.find(driver.store_id).id.to_s

        if stores.include?(storeid)
          printf(f, "Order-" + order.id.to_s + "." + "Driver-" + driver.id.to_s + "        1" + "\n")

        end

      end


    end

    printf(f, "/" + "\n\n")


    # Zeitfenster Low

    printf(f, "Parameter\n  tf(i) /\n")

    @drivers.each do |driver|
      printf(f, "Driver-" + driver.id.to_s + "        " + @shiftbegin + "\n")

    end

    @orders.each do |order|

      t = order.timewindow.split("-")[0]

        printf(f, "Order-" + order.id.to_s + "        " + t + "\n")

    end

    printf(f, "/" + "\n\n")

    # Zeitfenster High

    printf(f, "Parameter\n  ts(i) /\n")

    @drivers.each do |driver|
      printf(f, "Driver-" + driver.id.to_s + "        " + @shiftend + "\n")

    end

    @orders.each do |order|

      t = order.timewindow.split("-")[1]

      printf(f, "Order-" + order.id.to_s + "        " + t + "\n")

    end

    printf(f, "/" + "\n\n")


    # Benötigte Boxen

    printf(f, "Parameter\n  d(i,p) /\n")

    @orders.each do |order|

      if order.neededboxes > 0
      printf(f, "Order-" + order.id.to_s + "." + "box"  "        " + order.neededboxes.to_s + "\n")
      end
      if order.neededcoolingboxes > 0
        printf(f, "Order-" + order.id.to_s + "." + "cbox"  "        " + order.neededcoolingboxes.to_s + "\n")
      end
      if order.neededfreezingboxes > 0
        printf(f, "Order-" + order.id.to_s + "." + "fbox"  "        " + order.neededfreezingboxes.to_s + "\n")
      end
    end

    printf(f, "/" + "\n\n")


    # Kapazität an Boxen

    printf(f, "Parameter\n  s(i,p) /\n")

    @drivers.each do |d|

      driver = Vehicle.find(d.vehicle_id)

      if driver.boxcapacity > 0
        printf(f, "Driver-" + d.id.to_s + "." + "box"  "        " + driver.boxcapacity.to_s + "\n")
      end
      if driver.coolingboxcapacity > 0
        printf(f, "Driver-" + d.id.to_s + "." + "cbox"  "        " + driver.coolingboxcapacity.to_s + "\n")
      end
      if driver.freezingboxcapacity > 0
        printf(f, "Driver-" + d.id.to_s + "." + "fbox"  "        " + driver.freezingboxcapacity.to_s + "\n")
      end
    end

    printf(f, "/" + "\n\n")


    # Fahrtzeiten

    printf(f, "Parameter\n  fz(i,j) /\n")

    # Von Fahrern zu Kunden

    @drivers.each do |driver|
      @orders.each do |order|
        distance = Distance.find_by_typey_and_from_id_and_to_id(2, Store.find(driver.store_id).id, Customer.find(order.customer_id).id)
        printf(f, "Driver-" + driver.id.to_s + "." + "Order-" + order.id.to_s + "        " + distance.traveltime.to_s + "\n")
      end
    end

    @orders.each do |orderfrom|
      @orders.each do |orderto|
        if orderfrom != orderto
          distance = Distance.find_by_typey_and_from_id_and_to_id(1, Customer.find(orderfrom.customer_id).id, Customer.find(orderto.customer_id).id)
          if distance == nil
            printf(f, "Order-" + orderfrom.id.to_s + "." + "Order-" + orderto.id.to_s + "        " + "0.0" + "\n")
          else
            printf(f, "Order-" + orderfrom.id.to_s + "." + "Order-" + orderto.id.to_s + "        " + distance.traveltime.to_s + "\n")
          end
        end
      end
    end

    printf(f, "/" + "\n\n")




    f.close

    # INCLUDE DATEI FERTIG

    # Das GAMS Modell starten


    gamspath = Option.find_by_name("gamspath").value
    system gamspath + " homedelivery"



    ############# SOLUTION ################


    # Zugeordnetes Geschäft und Fahrer in die Bestellung eintragen

    @allocateddrivers = []

    if (File.exist?("homedeliverysolution-allocation.txt"))

      fil=File.open("homedeliverysolution-allocation.txt", "r")

      fil.each { |line| # printf(f,line)

        sa = line.split(" ; ")
        order = sa[0].delete " \n"    # Order-ID
        driver = sa[1].delete " \n"    # Driver-ID

        orderid = order.split("-")[1]
        driverid = driver.split("-")[1]

        if order.split("-")[0] != "Driver"

        myorder = Order.find(orderid)

        myorder.allocateddriver = driverid
        myorder.allocatedstore = Store.find(Driver.find(driverid).store_id).id
        myorder.save

        else
          # Hier für die spätere Routen Zuordnung definieren welche Fahrer zugeordnet sind

          @allocateddrivers.push(Driver.find(driverid))

        end

      }


      fil.close

    else
      # Wenn keine solution.txt Datei vorhanden ist
      flash.now[:danger] = "Kein Ergebniss berechnet!"

    end



    # Ankunftszeit in Bestellung eintragen

    if (File.exist?("homedeliverysolution-arrivaltime.txt"))

      fil=File.open("homedeliverysolution-arrivaltime.txt", "r")

      fil.each { |line| # printf(f,line)

        sa = line.split(" ; ")
        order = sa[0].delete " \n"    # Order-ID
        time = sa[1].delete " \n"     # Ankunftszeit

        orderid = order.split("-")[1]

        if order.split("-")[0] != "Driver"

          myorder = Order.find(orderid)

          myorder.estimatedtime = time
          myorder.save

        end

      }


      fil.close

    else
      # Wenn keine solution.txt Datei vorhanden ist
      flash.now[:danger] = "Kein Ergebniss berechnet!"

    end




    # Routen Erstellen
    if (File.exist?("homedeliverysolution-routes.txt"))

      # Zunächst alle Abschnitte in die DB (Direction) eintragen

        # Zuvor alle alten Einträge löschen, falls vorhanden
      if Direction.where(optimization_id: optid).exists?
        Direction.where(optimization_id: optid).destroy_all
      end

    fil=File.open("homedeliverysolution-routes.txt", "r")

    fil.each { |line| # printf(f,line)

      sa = line.split(" ; ")
      from = sa[0].delete " \n"    # NAME-ID
      to = sa[1].delete " \n"    # NAME-ID
      by = sa[2].delete " \n"    # Driver-ID

      fromid = from.split("-")[1].to_i
      toid = to.split("-")[1].to_i
      byid = by.split("-")[1].to_i

      if from.split("-")[0] == "Driver"
        typey = "start"
      elsif to.split("-")[0] == "Driver"
          typey = "end"
      else
        typey = "C2C"
      end

      direction = Direction.new(optimization_id: optid, from: fromid, to: toid, by: byid, typey: typey)
      direction.save

    }

    fil.close

      # Dann für jeden zugeordneten Fahrer die Route aufbauen

    @allocateddrivers.each do |driver|
      @route = []
      @traveltime = 0
      @traveldistance = 0
      @boxes = 0
      @coolingboxes = 0
      @freezingboxes = 0

      @directions = Direction.where(optimization_id: optid)

      # Den Start suchen
      @start = @directions.find_by(by: driver.id, typey: "start")
      @route.push(@start.to)

      # Erste Distanz hinzufügen + Boxen
      mydistance = Distance.find_by(from_id: Store.find(driver.store_id).id , to_id: Order.find(@start.to).customer_id , typey: 2)
      @traveldistance += mydistance.traveldistance
      @traveltime += mydistance.traveltime
      @boxes += Order.find(@start.to).neededboxes
      @coolingboxes += Order.find(@start.to).neededcoolingboxes
      @freezingboxes += Order.find(@start.to).neededfreezingboxes

      # Nächsten Kunden suchen

      @check = false
      @i = 1

      while @check == false
        if @i > Order.all.count + 10
          # Das ist nur Absicherung, damit die Schleife einen Notausgang hat
          @check = true
          flash[:danger] = "Eine Schleife musste unerwartet abgebrochen werden."
        end

        @next = @directions.find_by(from: @start.to, by: driver.id, typey: "C2C")
        if @next == nil
         @next = @directions.find_by(by: driver.id, typey: "end")
        end

        if  @next.typey == "end"
          # Letzte Distanz hinzufügen
          mydistance = Distance.find_by(from_id: Order.find(@next.from).customer_id , to_id: Store.find(driver.store_id).id , typey: 3)
          @traveldistance += mydistance.traveldistance
          @traveltime += mydistance.traveltime + Option.find_by_name("servicetime").value.to_f

          @check = true   # Beendet die Schleife, da dies der letzte Abschnitt der Route war
        else
          @route.push(@next.to)

          # Distanz hinzufügen + Boxen
          if Order.find(@next.from).customer_id == Order.find(@next.to).customer_id
          else
            mydistance = Distance.find_by(from_id: Order.find(@next.from).customer_id , to_id: Order.find(@next.to).customer_id , typey: 1)
            @traveldistance += mydistance.traveldistance
            @traveltime += mydistance.traveltime + Option.find_by_name("servicetime").value.to_f
          end
          @boxes += Order.find(@next.to).neededboxes
          @coolingboxes += Order.find(@next.to).neededcoolingboxes
          @freezingboxes += Order.find(@next.to).neededfreezingboxes



          @start = @next
          @i += 1
        end

      end

      finalroute = @route.join("->")

      @worktimecosts = @traveltime / 60 * Option.find_by_name("hourcosts").value.to_f
      @drivingcosts = @traveldistance * Option.find_by_name("drivingcosts").value.to_f
      @emissions = @traveldistance * Vehicle.find(driver.vehicle_id).emissions

      myroute = Route.new(driver_id: driver.id, optimization_id: optid, route: finalroute,
                          traveltime: @traveltime, traveldistance: @traveldistance,
                          worktimecosts: @worktimecosts, drivingcosts: @drivingcosts, emissions: @emissions,
                          boxes: @boxes, coolingboxes: @coolingboxes, freezingboxes: @freezingboxes)

      myroute.save



    end








    else
      # Wenn keine solution.txt Datei vorhanden ist
      flash[:danger] = "Kein Ergebniss berechnet!"

    end






    # In alle Bestellungen die aktuelle Optimierung eintragen und den Status ändern
    @orders.each do |order|
      order.optimization = optid
      order.status = 2
      order.save
    end







    end




    end






end
