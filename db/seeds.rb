# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Zunächst für jede Rolle einen Testuser erstellen


# ADMIN
@user1 = User.create!(name: "Admin",
             email: "admin@egrocery-eus.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true)

@customeradmin = Customer.create!(name: "Admin",
                              user_id: @user1.id,
                              city: "Hannover",
                              street: "Welfengarten 1",
                              zip: 30167,
                              workcity: "Hannover",
                              workstreet: "Welfengarten 1",
                              workzip: 30167)

Cart.create!(customer_id: @customeradmin.id)

# KUNDE 1
@user2 = User.create!(name: "Kunde1",
                      email: "kunde1@egrocery-eus.com",
                      password: "123456",
                      password_confirmation: "123456")

@customer1 = Customer.create!(name: "Kunde1",
                                  user_id: @user2.id,
                                  city: "Hannover",
                                  street: "Kronenstraße 45",
                                  zip: 30161,
                                  workcity: "Hannover",
                                  workstreet: "Welfengarten 1",
                                  workzip: 30167)

Cart.create!(customer_id: @customer1.id)

# KUNDE 2
@user3 = User.create!(name: "Kunde2",
                      email: "kunde2@egrocery-eus.com",
                      password: "123456",
                      password_confirmation: "123456")

@customer2 = Customer.create!(name: "Kunde2",
                              user_id: @user3.id,
                              city: "Hannover",
                              street: "Vahrenwalder Str. 90",
                              zip: 30171,
                              workcity: "Hannover",
                              workstreet: "Welfengarten 1",
                              workzip: 30167)

Cart.create!(customer_id: @customer2.id)

# KUNDE 3
@user4 = User.create!(name: "Kunde3",
                      email: "kunde3@egrocery-eus.com",
                      password: "123456",
                      password_confirmation: "123456")

@customer3 = Customer.create!(name: "Kunde3",
                              user_id: @user4.id,
                              city: "Hannover",
                              street: "Nedderfeldstraße 9",
                              zip: 30451,
                              workcity: "Hannover",
                              workstreet: "Welfengarten 1",
                              workzip: 30167)

Cart.create!(customer_id: @customer3.id)

# Geschäfte

@store1 = Store.create!(name: "Supermarkt1",
                        city: "Hannover", street: "Spielhagenstraße 23A", zip: 30171,
                        concept: 1)

@store2 = Store.create!(name: "Supermarkt2",
                        city: "Hannover", street: "Hildesheimer Straße 27-29", zip: 30169,
                        concept: 2)

@store3 = Store.create!(name: "Abholstation",
                        city: "Hannover", street: "Hildesheimer Straße 114", zip: 30173,
                        concept: 3)

@store4 = Store.create!(name: "Zentrallager",
                        city: "Hannover", street: "Wohlenbergstraße 25", zip: 30179,
                        concept: 4)

# Fahrzeuge

@vehicle1 = Vehicle.create!(name: "Mercedes Sprinter",
                        range: 750,
                        emissions: 180,
                        speed: 28,
                        boxcapacity: 25,
                        coolingboxcapacity: 15,
                        freezingboxcapacity: 10)

@vehicle2 = Vehicle.create!(name: "IVECO Daily",
                            range: 2400,
                            emissions: 217,
                            speed: 28,
                            boxcapacity: 120,
                            coolingboxcapacity: 60,
                            freezingboxcapacity: 40)

@vehicle3 = Vehicle.create!(name: "Volkswagen T6",
                            range: 1000,
                            emissions: 156,
                            speed: 28,
                            boxcapacity: 15,
                            coolingboxcapacity: 10,
                            freezingboxcapacity: 10)

# FAHRER 1

@user5 = User.create!(name: "Fahrer1",
                      email: "fahrer1@egrocery-eus.com",
                      password: "123456",
                      password_confirmation: "123456")

@driver1 = Driver.create!(name: "Fahrer1",
                            store_id: @store2.id,
                            vehicle_id: @vehicle1.id)

# FAHRER 2

@user6 = User.create!(name: "Fahrer2",
                      email: "fahrer2@egrocery-eus.com",
                      password: "123456",
                      password_confirmation: "123456")

@driver2 = Driver.create!(name: "Fahrer2",
                          store_id: @store2.id,
                          vehicle_id: @vehicle3.id)

# FAHRER 3

@user7 = User.create!(name: "Fahrer3",
                      email: "fahrer3@egrocery-eus.com",
                      password: "123456",
                      password_confirmation: "123456")

@driver3 = Driver.create!(name: "Fahrer3",
                          store_id: @store4.id,
                          vehicle_id: @vehicle2.id)

# Bestellungen

@order1 = Order.create!(customer_id: @customer1.id,
                            allocationmethod: 3,
                            day: "2018-03-05",
                            timewindow: "480-600",
                            products: "1-2,2-1,3-5",
                            neededboxes: 2.0,
                            neededcoolingboxes: 0.0,
                            neededfreezingboxes: 0.0,
                            allocatedstore: 2,
                            allocateddriver: 2,
                            estimatedtime: 600,
                            status: 2,
                            price: 10.57,
                            optimization: 1,
                            possiblestores: "1,2,3,4")

@order2 = Order.create!(customer_id: @customer2.id,
                        allocationmethod: 1,
                        day: "2018-03-05",
                        timewindow: "840-960",
                        products: "4-2,5-1,6-2",
                        neededboxes: 0.0,
                        neededcoolingboxes: 1.0,
                        neededfreezingboxes: 1.0,
                        allocatedstore: 2,
                        allocateddriver: 2,
                        estimatedtime: 620,
                        status: 2,
                        price: 12.17,
                        optimization: 1,
                        possiblestores: "1,2,3,4")

@order3 = Order.create!(customer_id: @customer3.id,
                        allocationmethod: 3,
                        day: "2018-03-05",
                        timewindow: "600-720",
                        products: "7-2,8-4,9-2",
                        neededboxes: 1.0,
                        neededcoolingboxes: 0.0,
                        neededfreezingboxes: 2.0,
                        allocatedstore: 4,
                        allocateddriver: 4,
                        estimatedtime: 620,
                        status: 2,
                        price: 17.94,
                        optimization: 1,
                        possiblestores: "1,2,3,4")

@order4 = Order.create!(customer_id: @customer2.id,
                        allocationmethod: 3,
                        day: "2018-03-05",
                        timewindow: "600-720",
                        products: "10-2,11-1,9-2",
                        neededboxes: 1.0,
                        neededcoolingboxes: 0.0,
                        neededfreezingboxes: 0.0,
                        allocatedstore: 4,
                        allocateddriver: 4,
                        estimatedtime: 620,
                        status: 2,
                        price: 17.94,
                        optimization: 1,
                        possiblestores: "1,2,3,4")



# Optimierungen

@opt1 = Optimization.create!(name: "Beispiel Optimierung 1",
                            optimizationtype: 3,
                            orders: 0,
                            totalboxes: 4,
                            totalcoolingboxes: 3,
                            totalfreezingboxes: 3,
                            allocation: "1-1,2-1,3-1,4-1",
                            totaltraveltime: 98,
                            totaldistance: 33,
                            turnover: 100,
                            productcosts: 81,
                            worktimecosts: 9,
                            drivingcosts: 2,
                            profit: 8,
                            emissions: 4290,
                            stores: 245,
                            orderslist: "1,2,3,4",
                            statustype: 12,
                            realtotaldistance: 56,
                            realtotalemissions: 7020)

@opt2 = Optimization.create!(name: "Beispiel Optimierung 2",
                            optimizationtype: 4,
                            orders: 0,
                            totalboxes: nil,
                            totalcoolingboxes: nil,
                            totalfreezingboxes: nil,
                            allocation: "1-1,2-1,3-3,4-3",
                            totaltraveltime: nil,
                            totaldistance: 45,
                            turnover: 100,
                            productcosts: 81,
                            worktimecosts: 4,
                            drivingcosts: 0,
                            profit: 15,
                            emissions: 3450,
                            stores: 245,
                            orderslist: "1,2,3,4",
                            statustype: 12,
                            realtotaldistance: 56,
                            realtotalemissions: 5130)

# Touren

@route1 = Route.create!(driver_id: 1,
                             optimization_id: 1,
                             route: "1->2->3->4",
                             traveltime: 42,
                              traveldistance: 33,
                             worktimecosts: 7,
                             drivingcosts: 2,
                             emissions: 4290,
                             boxes: 4,
                             coolingboxes: 3,
                             freezingboxes: 3)




# Produkte

@product1 = Product.create!(name: "Bananen",
                              brand: "MyBauer",
                              price: 1.69,
                              discountprice: 0.95,
                              weight: 1000.0,
                              volume: 2.0,
                              vegan: true,
                              bio: true,
                              picture: "ProductImages/bananen.jpeg",
                              durability: 0,
                              category: "Obst")

@product2 = Product.create!(name: "Eisbergsalat",
                            brand: "MyBauer",
                            price: 0.69,
                            weight: 400.0,
                            volume: 1.5,
                            vegan: true,
                            bio: true,
                            picture: "ProductImages/salat.jpeg",
                            durability: 0,
                            category: "Gemüse")

@product3 = Product.create!(name: "Paprika",
                            brand: "MyBauer",
                            price: 1.29,
                            weight: 200.0,
                            volume: 0.4,
                            vegan: true,
                            bio: true,
                            picture: "ProductImages/paprika.jpg",
                            durability: 0,
                            category: "Gemüse")

@product4 = Product.create!(name: "Gouda",
                            brand: "YoProds",
                            price: 1.89,
                            weight: 400.0,
                            volume: 0.7,
                            vegan: false,
                            bio: false,
                            picture: "ProductImages/Gouda.jpeg",
                            durability: 1,
                            category: "Eier, Käse, Milch")

@product5 = Product.create!(name: "Lachs (frisch)",
                            brand: "Norwegs",
                            price: 4.99,
                            weight: 400.0,
                            volume: 0.8,
                            vegan: false,
                            bio: false,
                            picture: "ProductImages/lachs.jpg",
                            durability: 1,
                            category: "Fisch")

@product6 = Product.create!(name: "Bratwurst",
                            brand: "Meaty",
                            price: 2.19,
                            weight: 500.0,
                            volume: 1.0,
                            vegan: false,
                            bio: false,
                            picture: "ProductImages/bratwurst.jpg",
                            durability: 1,
                            category: "Wurst")

@product7 = Product.create!(name: "Pommes",
                            brand: "NederProds",
                            price: 4.19,
                            weight: 2000.0,
                            volume: 7.0,
                            vegan: false,
                            bio: false,
                            picture: "ProductImages/pommes.jpg",
                            durability: 2,
                            category: "Fertiggerichte")

@product8 = Product.create!(name: "Himbeeren (TK)",
                            brand: "FreezyFruits",
                            price: 2.89,
                            weight: 500.0,
                            volume: 2.0,
                            vegan: false,
                            bio: true,
                            picture: "ProductImages/himbeeren.jpg",
                            durability: 2,
                            category: "Gemüse, Obst & Kräuter")

@product9 = Product.create!(name: "Erbsen & Möhren",
                            brand: "Bondkons",
                            price: 1.49,
                            weight: 800.0,
                            volume: 0.9,
                            vegan: true,
                            bio: false,
                            picture: "ProductImages/konserve-erbsenmoehren.jpeg",
                            durability: 0,
                            category: "Konserven")

@product10 = Product.create!(name: "Baguette",
                            brand: "Italio",
                            price: 1.19,
                            weight: 300.0,
                            volume: 3.0,
                            vegan: false,
                            bio: true,
                            picture: "ProductImages/baguette.jpg",
                            durability: 0,
                            category: "Backwaren")

@product11 = Product.create!(name: "Kartoffeln",
                             brand: "MyBauer",
                             price: 3.69,
                             weight: 2000.0,
                             volume: 6.0,
                             vegan: true,
                             bio: true,
                             picture: "ProductImages/kartoffeln.jpg",
                             durability: 0,
                             category: "Gemüse")

# Options

@option1 = Option.create!(name: "categorys",
                          value: "Obst-Gemüse-Kräuter-Eier, Käse, Milch-Wurst-Fleisch-Fisch-Fisch & Fleisch-Fertiggerichte-Gemüse, Obst & Kräuter-Eis-Konserven-Teigwaren-Backwaren-Cerealien-Backzutaten")

@option2 = Option.create!(name: "concepts",
                          value: "Warehouse-Home-Delivery/Central-Pick-Up-Station/Store-Pick-Up, Home-Delivery/Store-Pick-Up")

@option3 = Option.create!(name: "method",
                          value: "Pick-Up,Home-Delivery ")

@option4 = Option.create!(name: "boxsize",
                          value: "15")

@option5 = Option.create!(name: "coolingboxsize",
                          value: "7")

@option6 = Option.create!(name: "freezingboxsize",
                          value: "7")

@option7 = Option.create!(name: "gamspath",
                          value: "/Applications/GAMS24.7/sysdir/gams")

@option8 = Option.create!(name: "hourcosts",
                          value: "18")

@option9 = Option.create!(name: "drivingcosts",
                          value: "0.5")

@option10 = Option.create!(name: "cartcosts",
                          value: "0.812")

@option11 = Option.create!(name: "timeperproduct",
                          value: "15")

@option12 = Option.create!(name: "servicetime",
                          value: "15")

@option13 = Option.create!(name: "timewindows",
                          value: "480-600,600-720,720-840,840-960,960-1080,1080-1200")

@option14 = Option.create!(name: "gamsstatus",
                          value: "1")

@option15 = Option.create!(name: "standardemissions",
                          value: "131")


# Verfügbarkeiten

@products = Product.all
@stores = Store.all


@products.each do |product|

  @stores.each do |store|


    if !Stock.where(["product_id = :product_id and store_id = :store_id", { product_id: product.id, store_id: store.id }]).exists?

      @mystock = [true, true, true, true, true, false].sample

      newstock = Stock.new(:product_id => product.id, :store_id => store.id, :stock => @mystock)
      newstock.save

    end



  end

end



# Distanzen

@customers = Customer.all
@stores = Store.all




# types: 1 = Kunde zu Kunde
#        2 = Geschäft zu Kunde
#        3 = Kunde zu Geschäft

Distance.where(:status => "OVER_QUERY_LIMIT").destroy_all
Distance.where(:status => "ZERO_RESULTS").destroy_all


# Distanzen von Kunden zu Geschäften

@customers.each do |from|

  @stores.each do |to|

    if !Distance.where(["typey = :typey and from_id = :from_id and to_id = :to_id", {:typey => 3, from_id: from.id, to_id: to.id }]).exists?

      origin = from.street + " " + from.zip.to_s
      destination = to.street + " " + to.zip.to_s

      directions = GoogleDirections.new(origin, destination)

      status = directions.status
      traveltime = directions.drive_time_in_minutes
      traveldistance = directions.distance_in_miles

      newdistance = Distance.new(:typey => 3, :from_id => from.id, :to_id => to.id, :traveltime => traveltime, :traveldistance => traveldistance, :status => status )
      newdistance.save
      sleep(0.05)

    end

  end

end




# types: 1 = Kunde zu Kunde
#        2 = Geschäft zu Kunde
#        3 = Kunde zu Geschäft
#        4 = Kunde-Arbeit zu Geschäften


######### ------  ARBEITSADRESSEN  ------- ##########



# Distanzen von Arbeitsadresse zu Geschäften

@customers.each do |from|

  @stores.each do |to|

    if !Distance.where(["typey = :typey and from_id = :from_id and to_id = :to_id", {:typey => 4, from_id: from.id, to_id: to.id }]).exists?

      origin = from.workstreet + " " + from.workzip.to_s
      destination = to.street + " " + to.zip.to_s

      directions = GoogleDirections.new(origin, destination)

      status = directions.status
      traveltime = directions.drive_time_in_minutes
      traveldistance = directions.distance_in_miles

      newdistance = Distance.new(:typey => 4, :from_id => from.id, :to_id => to.id, :traveltime => traveltime, :traveldistance => traveldistance, :status => status )
      newdistance.save
      sleep(0.05)

    end

  end

end


# Distanzen von Kunden zu Geschäften

@customers.each do |from|

  @stores.each do |to|

    if !Distance.where(["typey = :typey and from_id = :from_id and to_id = :to_id", {:typey => 3, from_id: from.id, to_id: to.id }]).exists?

      origin = from.street + " " + from.zip.to_s
      destination = to.street + " " + to.zip.to_s

      directions = GoogleDirections.new(origin, destination)

      status = directions.status
      traveltime = directions.drive_time_in_minutes
      traveldistance = directions.distance_in_miles

      newdistance = Distance.new(:typey => 3, :from_id => from.id, :to_id => to.id, :traveltime => traveltime, :traveldistance => traveldistance, :status => status )
      newdistance.save
      sleep(0.05)

    end

  end

end



# Distanzen von Arbeitsadresse zum Kunden

@customers.each do |from|


  if !Distance.where(["typey = :typey and from_id = :from_id and to_id = :to_id", {:typey => 5, from_id: from.id, to_id: from.id }]).exists?

    origin = from.workstreet + " " + from.workzip.to_s
    destination = from.street + " " + from.zip.to_s

    directions = GoogleDirections.new(origin, destination)

    status = directions.status
    traveltime = directions.drive_time_in_minutes
    traveldistance = directions.distance_in_miles

    newdistance = Distance.new(:typey => 5, :from_id => from.id, :to_id => from.id, :traveltime => traveltime, :traveldistance => traveldistance, :status => status )
    newdistance.save
    sleep(0.05)


  end

end


######### ------  HEIMADRESSEN  ------- ##########


# Distanzen zwischen Kunden

@customers.each do |from|

  @customers.each do |to|

    if from.id != to.id

      if !Distance.where(["typey = :typey and from_id = :from_id and to_id = :to_id", {typey: 1, from_id: from.id, to_id: to.id }]).exists?

        origin = from.street + " " + from.zip.to_s
        destination = to.street + " " + to.zip.to_s

        directions = GoogleDirections.new(origin, destination)

        traveltime = directions.drive_time_in_minutes
        traveldistance = directions.distance_in_miles
        status = directions.status

        newdistance = Distance.new(:typey => 1, :from_id => from.id, :to_id => to.id, :traveltime => traveltime, :traveldistance => traveldistance, :status => status )
        newdistance.save

        sleep(0.1)
      end

    end

  end

end


# Distanzen von Geschäften zu Kunden

@stores.each do |from|

  @customers.each do |to|

    if !Distance.where(["typey = :typey and from_id = :from_id and to_id = :to_id", {:typey => 2, from_id: from.id, to_id: to.id }]).exists?

      origin = from.street + " " + from.zip.to_s
      destination = to.street + " " + to.zip.to_s

      directions = GoogleDirections.new(origin, destination)

      status = directions.status
      traveltime = directions.drive_time_in_minutes
      traveldistance = directions.distance_in_miles

      newdistance = Distance.new(:typey => 2, :from_id => from.id, :to_id => to.id, :traveltime => traveltime, :traveldistance => traveldistance, :status => status )
      newdistance.save
      sleep(0.05)

    end

  end

end