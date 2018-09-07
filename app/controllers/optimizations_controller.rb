class OptimizationsController < ApplicationController
  include OptimizationsHelper
  include PickuphomeHelper
  include PickupworkHelper
  include HomedeliveryHelper
  before_action :set_optimization, only: [:show, :edit, :update, :destroy]
  before_action :admincheck

  def pickuponlyhome

    redirect_to :back
  end

  def capacitytest

    redirect_to :back
  end


  # GET /optimizations
  # GET /optimizations.json
  def index
    @optimizations = Optimization.all
  end

  # GET /optimizations/1
  # GET /optimizations/1.json
  def show
  end

  # GET /optimizations/new
  def new
    @optimization = Optimization.new
  end

  # GET /optimizations/1/edit
  def edit
  end

  # POST /optimizations
  # POST /optimizations.json
  def create

    # Zunächst alle vorhandenen Lösungsdateien löschen
    if File.exist?("homedeliverysolution-allocation.txt")
      File.delete("homedeliverysolution-allocation.txt")
    end
    if File.exist?("homedeliverysolution-arrivaltime.txt")
      File.delete("homedeliverysolution-arrivaltime.txt")
    end
    if File.exist?("homedeliverysolution-routes.txt")
      File.delete("homedeliverysolution-routes.txt")
    end


    @optimization = Optimization.new(optimization_params)

    st = @optimization.stores
    od = @optimization.orders
    stat = @optimization.statustype
    @optimization.save

    #checkstocks(st,od)

    # Bei "Wie gewünscht"
    if @optimization.optimizationtype == 1
      # Die Stores und Bestellungen müssen sortiert werden

      # Zunächst die Bestellungen

        # Status lesen
        if stat == 1
          @mystatus = [1]
        elsif stat == 2
          @mystatus = [2]
        elsif stat == 12
          @mystatus = [1, 2]
        end

      @pickuphomeorders = Order.where(:allocationmethod => 1, :status => @mystatus)

      @pickupworkorders = Order.where(:allocationmethod => 2, :status => @mystatus)

      @homedeliveryorders = Order.where(:allocationmethod => 3, :status => @mystatus)


      # Dann die Geschäfte

        if st == 12
          @pickuphomestores = Store.where(:concept => [1,2])
          @pickupworkstores = Store.where(:concept => [1,2])
          @homedeliverystores = Store.where(:concept => [2])

        elsif st == 123
          @pickuphomestores = Store.where(:concept => [1,2,3])
          @pickupworkstores = Store.where(:concept => [1,2,3])
          @homedeliverystores = Store.where(:concept => [2])

        elsif st == 124
          @pickuphomestores = Store.where(:concept => [1,2])
          @pickupworkstores = Store.where(:concept => [1,2])
          @homedeliverystores = Store.where(:concept => [2,4])

        elsif st == 125
          @pickuphomestores = Store.where(:concept => [1,2])
          @pickupworkstores = Store.where(:concept => [1,2])
          @homedeliverystores = Store.where(:concept => [2,5])

        elsif st == 34
          @pickuphomestores = Store.where(:concept => [3])
          @pickupworkstores = Store.where(:concept => [3])
          @homedeliverystores = Store.where(:concept => [4])

        elsif st == 35
          @pickuphomestores = Store.where(:concept => [3])
          @pickupworkstores = Store.where(:concept => [3])
          @homedeliverystores = Store.where(:concept => [5])

        elsif st == 345
          @pickuphomestores = Store.where(:concept => [3])
          @pickupworkstores = Store.where(:concept => [3])
          @homedeliverystores = Store.where(:concept => [4,5])

        else
          @pickuphomestores = Store.where(:concept => [1,2,3])
          @pickupworkstores = Store.where(:concept => [1,2,3])
          @homedeliverystores = Store.where(:concept => [2,4,5])
        end


      # Jetzt die jeweiligen Modelle starten und dafür die jeweiligen Stores und Orders übergeben

      # Pick Up from Home
        # Immer zuerst prüfen ob es für die Auswahl Geschäfte und Bestellungen gibt:
        if @pickuphomeorders.any? and @pickuphomestores.any?
          checkstocks(@pickuphomestores,@pickuphomeorders,@optimization.id,stat)

        startpickuphome(@pickuphomestores,@pickuphomeorders,@optimization.id,stat)

        else
          @danger = 1
          dangermessage1 = "Pick-Up Home "
        end


      # Pick Up from Work
        # Immer zuerst prüfen ob es für die Auswahl Geschäfte und Bestellungen gibt:
        if @pickupworkorders.any? and @pickupworkstores.any?
          checkstocks(@pickupworkstores,@pickupworkorders,@optimization.id,stat)

        startpickupwork(@pickupworkstores,@pickupworkorders,@optimization.id,stat)

        else
          @danger = 1
          dangermessage2 = "Pick-Up Work "
        end

      # Home-Delivery
      # Immer zuerst prüfen ob es für die Auswahl Geschäfte und Bestellungen gibt:
        if @homedeliveryorders.any? and @homedeliverystores.any?
          # Hier dann speziell nochmal prüfen ob es auch Fahrer für die Geschäfte gibt
          @drivers = []
          @homedeliverystores.each do |store|
            mydrivers = Driver.where(store_id: store.id)
            mydrivers.each do |myd|
              @drivers.push(myd)

            end
          end

          if @drivers.empty? == false

          checkstocks(@homedeliverystores,@homedeliveryorders,@optimization.id,stat)

          starthomedelivery(@homedeliverystores,@homedeliveryorders,@optimization.id,stat)
          else

            @danger = 1
            dangermessage3 = "Homedelivery "

          end


        else
          @danger = 1
          dangermessage3 = "Homedelivery "
        end

        putoptdata(@optimization.id)


    end

    if @danger == 1
      flash[:danger] = "Für folgende Modelle gab es keine Geschäfte oder Bestellungen: " + dangermessage1.to_s + dangermessage2.to_s + dangermessage3.to_s
      @optimization.destroy
      redirect_to new_optimization_path
    else


    if @optimization.optimizationtype == 2
      checkstocks(st,od,@optimization.id,stat)

      # Pick Up from Home
      startpickuphome(st,od,@optimization.id,stat)

      putoptdata(@optimization.id)

    elsif @optimization.optimizationtype == 4
      checkstocks(st,od,@optimization.id,stat)

      # Pick Up from Work
        startpickupwork(st,od,@optimization.id,stat)

        putoptdata(@optimization.id)

    elsif @optimization.optimizationtype == 3
      checkstocks(st,od,@optimization.id,stat)

      # Home-Delivery
      starthomedelivery(st,od,@optimization.id,stat)

      putoptdata(@optimization.id)
    end

    if $noorders == true
      @optimization.destroy
      redirect_to new_optimization_path
    else

      redirect_to @optimization
      flash[:success] = "Die Optimierung wurde erfolgreich abgeschlossen."

    end
    end


  end

  # PATCH/PUT /optimizations/1
  # PATCH/PUT /optimizations/1.json
  def update
    respond_to do |format|
      if @optimization.update(optimization_params)
        format.html { redirect_to @optimization, notice: 'Optimization was successfully updated.' }
        format.json { render :show, status: :ok, location: @optimization }
      else
        format.html { render :edit }
        format.json { render json: @optimization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /optimizations/1
  # DELETE /optimizations/1.json
  def destroy
    @optimization.destroy
    respond_to do |format|
      flash[:success] = "Optimierung erfolgreich gelöscht"
      format.html { redirect_to optimizations_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_optimization
      @optimization = Optimization.find(params[:id])
    end

    def admincheck
      if current_user.admin?
      else
        redirect_to root_path
        flash[:danger] = "Keine Berechtigung für diese Seite!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def optimization_params
      params.require(:optimization).permit(:realtotaldistance, :name, :optimizationtype, :orders, :totalboxes, :totalcoolingboxes, :totalfreezingboxes, :allocation, :routes, :totaltraveltime, :totaldistance, :turnover, :productcosts, :worktimecosts, :drivingcosts, :profit, :emissions, :stores, :orderslist, :statustype)
    end
end
