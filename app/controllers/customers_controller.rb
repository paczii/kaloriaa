class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :admincheck

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save

        format.html {
          if current_user.admin

            @user = User.create!(name: @customer.name.gsub(/\s+/, "").downcase,
                                 email: @customer.name.gsub(/\s+/, "").downcase + "@egrocery-eus.de",
                                 password: "123456",
                                 password_confirmation: "123456",
                                 driver: false )
            flash[:info] = "Kunde erfolgreich angelegt. E-Mail: " + @customer.name.gsub(/\s+/, "").downcase + "@egrocery-eus.de" + " / Passwort: 123456"
            flash[:danger] = "Nachdem ein Kunde angelegt wurde, müssen neue Distanzen berechnet werden!"

            @customer.user_id = @user.id
            @customer.save

            @cart = Cart.create!(customer_id: @customer.id)
          else
            flash[:success] = "Kundendaten erfolgreich angelegt."
          end
          redirect_to User.find(@customer.user_id) }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash[:success] = "Kundendaten erfolgreich bearbeitet."
        format.html { redirect_to User.find(@customer.user_id) }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
   Distance.where(typey: 1, from_id: @customer.id).destroy_all
   Distance.where(typey: 1, to_id: @customer.id).destroy_all
   Distance.where(typey: 2, to_id: @customer.id).destroy_all
   Distance.where(typey: 3, from_id: @customer.id).destroy_all



    @customer.destroy



    respond_to do |format|
      flash[:success] = "Kunde erfolgreich gelöscht."
      format.html { redirect_to customers_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def admincheck
      if current_user.admin? or current_customer == @customer
      else
        redirect_to root_path
        flash[:danger] = "Keine Berechtigung für diese Seite!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:user_id, :name, :city, :street, :zip, :costmodel, :favorites, :workcity, :workstreet, :workzip)
    end
end
