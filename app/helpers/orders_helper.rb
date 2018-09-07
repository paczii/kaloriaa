module OrdersHelper




  def startbinpacking(id, run)

    @totalvolume = []
    @neededbox = 0

    @counter = 0
    @order = Order.find(id)
    @products = @order.products
    @productanditemssarray = @products.split(",")

    newarray = Array.new

      @productanditemssarray.each do |a|
        pai = a.split("-")
        durability = Product.find(pai[0]).durability
        if durability.to_i == run

          newarray.push(a)


      end
    end

    @productanditemssarray = newarray

    @productanditemssarray.each do |a|
      pai = a.split("-")
      amount = pai[1].to_i

      # Für die Schätzung durch Divsion
      productvolume = Product.find(pai[0]).volume
      totalproductvolume = productvolume * amount
      @totalvolume.push(totalproductvolume)

      amount.times do |t|
        @counter += 1
      end
    end

    # Schätzung der benötigten Boxen
    volumesum = @totalvolume.inject(0){|sum,x| sum + x }
    @neededbox = volumesum / 100

   # flash[:info] = "Boxen: " + @neededbox.to_s
    #flash[:danger] = "Einzelvolumen: " + @totalvolume.to_s



    # Zunächst wird die Include Datei aufgebaut

    if File.exist?("binpacking.inc")
      File.delete("binpacking.inc")
    end

    # INCLUDE DATEI AUFBAUEN  -------------------------

    f=File.new("binpacking.inc", "w")

    # SETS
    printf(f, "set p / \n")
    printf(f, "Product1" + " * " + "Product" + @counter.to_s + "\n")
    printf(f, "/" + "\n\n")

    printf(f, "b / \n")
    printf(f, "Box1" + " * " + "Box" + @counter.to_s + "\n")
    printf(f, "/;" + "\n\n")


    # PARAMETER

    # Kapazität der Boxen (ist fix)

    printf(f, "Parameter\n  c /\n")
    # Je nach Art der Box das entsprechende Volumen aus den Einstellungen nehmen
    if run == 0
    printf(f, Option.find_by_name("boxsize").value + "\n")
    elsif run == 1
      printf(f, Option.find_by_name("coolingboxsize").value + "\n")
    elsif run == 2
      printf(f, Option.find_by_name("freezingboxsize").value + "\n")
    end

    printf(f, "/" + "\n\n")



    # Gewünschte Zeiten der Anfragen

    printf(f, "Parameter\n  w(p) /\n")

    @i = 1

    @productanditemssarray.each do |a|
      pai = a.split("-")
      volume = Product.find(pai[0]).volume
      amount = pai[1].to_i

      amount.times do |t|
        printf(f, "Product" + @i.to_s + "      " + volume.to_s + "\n")

        @i += 1
      end
    end
    printf(f, "/" + "\n\n")


    f.close

    # INCLUDE DATEI FERTIG

    # Das GAMS Modell starten

    flash[:success] = "Die Optimierung wurde erfolgreich gestartet!"

    gamspath = Option.find_by_name("gamspath").value
    system gamspath + " binpacking"

    flash[:success] = "Die Optimierung wurde erfolgreich abgeschlossen!"

  end



  def binpackingresult(id, run)
  if (File.exist?("binsolution.txt"))

    # Ergebnisse aus der Solution-Datein in die Datenbank eintragen

    fil=File.open("binsolution.txt", "r")
    line=fil.readline
    sa=line.split(" ")
    @solutionZFW=sa[0]

      @order = Order.find(id)
    if run == 0
      @order.neededboxes = @solutionZFW
    elsif run == 1
      @order.neededcoolingboxes = @solutionZFW
    elsif run == 2
      @order.neededfreezingboxes = @solutionZFW
    end
      @order.save



    #flash.now[:success] = "Ergebnisse erfolgreich übertragen!"

    fil.close

  else
    # Wenn keine solution.txt Datei vorhanden ist
    #flash.now[:success] = "Noch kein Ergebniss berechnet!"

  end

    end


end
