class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]
  before_action :correct_driver, only: [:show]

  # GET /drivers
  # GET /drivers.json
  def index
    @drivers = Driver.all
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
  end

  # GET /drivers/new
  def new
    @driver = Driver.new
  end

  # GET /drivers/1/edit
  def edit
  end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.new(driver_params)



    respond_to do |format|
      if @driver.save

        User.create!(name: @driver.name,
                     email: @driver.name.gsub(/\s+/, "").downcase + "@egrocery-eus.de",
                     password: "123456",
                     password_confirmation: "123456",
                     driver: true )

        flash[:success] = "Fahrer erfolgreich erstellt."
        flash[:info] = "Es wurde ein Nutzer-Account für den Fahrer angelegt. E-Mail: " + @driver.name.gsub(/\s+/, "").downcase + "@egrocery-eus.de / Passwort: 123456"


        format.html { redirect_to @driver }
        format.json { render :show, status: :created, location: @driver }
      else
        format.html { render :new }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    respond_to do |format|
      if @driver.update(driver_params)
        flash[:success] = "Fahrer erfolgreich bearbeitet."
        format.html { redirect_to @driver }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver.destroy
    respond_to do |format|
      flash[:success] = "Fahrer erfolgreich gelöscht."

      format.html { redirect_to drivers_url }
      format.json { head :no_content }
    end
  end

  def correct_driver
    if current_user.driver? and @driver == Driver.find_by_name(current_user.name) or current_user.admin?
    else
      redirect_to Driver.find_by_name(current_user.name)

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def driver_params
      params.require(:driver).permit(:store_id, :vehicle_id, :name)
    end

end
