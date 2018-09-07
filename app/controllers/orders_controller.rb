class OrdersController < ApplicationController
  include OrdersHelper
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  def startbinpackingg
    id = Order.find(params[:orderid])

    startbinpacking(id, 0)
    binpackingresult(id, 0)

    startbinpacking(id, 1)
    binpackingresult(id, 1)

    startbinpacking(id , 2)
    binpackingresult(id, 2)

    redirect_to :back
  end


  # GET /orders
  # GET /orders.json
  def index
    if params[:mycustomer] != nil
      @orders = Order.where(customer_id: params[:mycustomer])
    else
    @orders = Order.where(:status => [1,2,3])
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def setcustomer
    @order = Order.find(params[:orderid])
    @order.status = 1
    @order.save

    render '_setcustomer'

  end


  def settimewindow
    @order = Order.find(params[:orderid])


    @order.timewindow = params[:mytw]
    @order.save


    @nb = 0
    @cb = 0
    @fb = 0

    # Berechnung der benötigten Boxen
        # Zuerst: Wie viele Produkte gibt es je Kühlart?
        @order.products.split(",").each do |pi|
          a = pi.split("-")
          product = a[0]
          d = Product.find(product.to_i).durability
          flash[:success] = "Bestellung erfolgreich aufgegeben."

          if d.to_i == 0
            @nb += 1
          elsif d.to_i == 1
            @cb += 1
          elsif d.to_i == 2
            @fb += 1
          end
        end

    id = @order.id

    if @nb != 0
    startbinpacking(id, 0)
    binpackingresult(id, 0)
    else
      @order.neededboxes = 0
    end

    if @cb != 0
    startbinpacking(id, 1)
    binpackingresult(id, 1)
    else
      @order.neededcoolingboxes = 0
    end

    if @fb != 0
    startbinpacking(id , 2)
    binpackingresult(id, 2)
    else
      @order.neededfreezingboxes = 0
    end
    @order.save

    #flash[:success] = @nb.to_s + "," + @cb.to_s + "," + @fb.to_s

    if current_user.admin?
      redirect_to setcustomer_path(:orderid => @order.id)
    else
      @order.customer_id = current_customer.id
      @order.status = 1
      @order.save
      flash[:success] = "Bestellung erfolgreich aufgegeben."

      redirect_to current_user
      end
  end

  # POST /orders
  # POST /orders.json
  def create
    mymethod = params[:mymethod]
    @totalprice = 0

    @order = Order.new(:allocationmethod => mymethod, :products => current_cart.products, :day => Date.today)

    if @order.products == nil or @order.products == ""

      flash[:danger] = "Der Warenkorb ist leer!"
      redirect_to current_cart

    else

    # Den Preis der Bestellung hinzufügen
    @order.products.split(",").each do |product|
      myproduct = product.split("-")
      theproduct = Product.find(myproduct[0])
      thenumber = myproduct[1]
      if theproduct.discountprice != nil
        price = theproduct.discountprice
      else
        price = theproduct.price
      end

      @totalprice += price.to_f * thenumber.to_f
    end
    @order.price = @totalprice

    @order.save


    respond_to do |format|
      if @order.save
        format.html { redirect_to edit_order_path(@order) }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

    end

  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        flash[:success] = "Bestellung erfolgreich aufgegeben."
        format.html { redirect_to @order }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
      flash[:success] = "Bestellung erfolgreich gelöscht."

      if !current_user.admin?
      redirect_to orders_path(:mycustomer => current_customer.id), 'data-turbolinks' => false
      else

    redirect_to orders_path

      end


  end





  def generateorder
    number = params[:number].to_i
    if number == Customer.all.count
      number = number - Order.all.count
    end

    number.times do
      @mycustomer = nil

      # Kunden aussuchen
     # Customer.all.each do |customer|
      Customer.order("RANDOM()").each do |customer|
        customerorders = Order.where(customer_id: customer.id)
        if customerorders.empty?
          @mycustomer = customer
          break
        end
      end

      if @mycustomer == nil

      else

      mymethod = Faker::Number.between(1, 3)
      @totalprice = 0
      products = []

      # Warenkorb zusammenstellen

      <<-DOC

      Product.all.each do |product|
        randomnumber = Faker::Number.between(1, 4)
        if randomnumber == 1
          randomamount = Faker::Number.between(1, 6)
          productstring = product.id.to_s + "-" + randomamount.to_s

          products.push(productstring)
        end
        end

        DOC

        #products = products.join(",")

        products = current_cart.products

      timewindows = Option.find_by_name("timewindows").value
      tw = timewindows.split(",").sample


      @order = Order.new(:timewindow => tw, :status => 1, :customer_id => @mycustomer.id, :allocationmethod => mymethod, :products => products, :day => Date.today)



      # Den Preis der Bestellung hinzufügen
      @order.products.split(",").each do |product|
        myproduct = product.split("-")
        theproduct = Product.find(myproduct[0])
        thenumber = myproduct[1]
        if theproduct.discountprice != nil
          price = theproduct.discountprice
        else
          price = theproduct.price
        end

        @totalprice += price.to_f * thenumber.to_f
      end
      @order.price = @totalprice

      @order.save

      # Die benötigten Boxen berechnen

      @nb = 0
      @cb = 0
      @fb = 0

      # Berechnung der benötigten Boxen
      # Zuerst: Wie viele Produkte gibt es je Kühlart?
      @order.products.split(",").each do |pi|
        a = pi.split("-")
        product = a[0]
        d = Product.find(product.to_i).durability

        if d.to_i == 0
          @nb += 1
        elsif d.to_i == 1
          @cb += 1
        elsif d.to_i == 2
          @fb += 1
        end
      end

      id = @order.id

      if @nb != 0
        startbinpacking(id, 0)
        binpackingresult(id, 0)
      else
        @order.neededboxes = 0
      end

      if @cb != 0
        startbinpacking(id, 1)
        binpackingresult(id, 1)
      else
        @order.neededcoolingboxes = 0
      end

      if @fb != 0
        startbinpacking(id , 2)
        binpackingresult(id, 2)
      else
        @order.neededfreezingboxes = 0
      end



      @order.save

      flash[:success] = "Bestellung(en) erfolgreich generiert."
    end
    end

    redirect_to generator_path
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :allocationmethod, :day, :timewindow, :products, :neededboxes, :neededcoolingboxes, :neededfreezingboxes, :allocatedstore, :allocateddriver, :estimatedtime, :status, :price, :optimization)
    end
end









