class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]
  before_action :admincheck

  def gamstest

    if File.exist?("gamstest-result.txt")
      File.delete("gamstest-result.txt")
    end

  @gamspath = Option.find_by_name("gamspath")

  system @gamspath.value + " gamstest"

  sleep(1)

  if File.exist?("gamstest-result.txt")

    flash[:success] = "GAMS Pfad Test war erfolgreich! Optimierungen können nun durchgeführt werden."
    status = Option.find_by_name("gamsstatus")
    status.value = "1"
    status.save
  else
    flash[:danger] = "GAMS Pfad Test fehlgeschlagen! Bitte GAMS Pfad prüfen."
    status = Option.find_by_name("gamsstatus")
    status.value = "0"
    status.save
  end



    redirect_to options_path
  end



  # GET /options
  # GET /options.json
  def index
    @options = Option.all
  end

  # GET /options/1
  # GET /options/1.json
  def show
  end

  # GET /options/new
  def new
    @option = Option.new
  end

  # GET /options/1/edit
  def edit
  end

  # POST /options
  # POST /options.json
  def create
    @option = Option.new(option_params)


        origin = "Welfengarten 1 30167"
        destination = @option.value + " " + @option.name.to_s

        directions = GoogleDirections.new(origin, destination)


        status = directions.status

        @option.destroy



        flash[:success] = "Status der Adresse: " + status

        redirect_to testaddresse_path
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        flash[:success] = "Option erfolgreich bearbeitet."

        format.html { redirect_to options_path }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    @option.destroy
    respond_to do |format|
      flash[:success] = "Option erfolgreich gelöscht."

      format.html { redirect_to options_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end

    def admincheck
      if current_user.admin?
      else
        redirect_to root_path
        flash[:danger] = "Keine Berechtigung für diese Seite!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:name, :value)
    end
end
