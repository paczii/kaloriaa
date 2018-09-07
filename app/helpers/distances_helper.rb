module DistancesHelper

  def testaddressefunction


  end

  def updatedistances_helper


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






end


end
