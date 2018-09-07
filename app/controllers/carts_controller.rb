class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  before_action :admincheck

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        @cart.products = ""
        @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    id = params[:myid]

    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to itemsupdate_path(mid: @cart.id, myid: id)}

        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end

  end

  def deleteitem
    a = []
    id = params[:myproduct]
    @cart = current_cart
    prodanditem = @cart.products.split(",")

    prodanditem.each do |pp|

      prod = pp.split("-")
      if prod[0] == id.to_s
        @deletedproduct = Product.find(prod[0].to_i)
      else
        a.push(pp)
      end
    end



    @cart.products = a.join(",")
    @cart.save

    flash[:success] = "Das Produkt ''" + @deletedproduct.name + "'' wurde aus dem Warenkorb entfernt"

    redirect_to current_cart
    end

  def itemsupdate

    @counter = 0
    id = params[:myid].split("-")[0]
    mycase = params[:myid].split("-")[1]

    @cart = Cart.find(params[:mid])
    if mycase == "c"
    a = []
    myproductsarray = @cart.products.split(",")
    myproductsarray.each do |prod|
      productanditem = prod.split("-")
      if productanditem[0] == id.to_s
        if @cart.items.to_i >= 11
          flash[:danger] = "Die Menge von 10 darf pro Produkt nicht überschritten werden"
          @counter = 2
          productanditem[1].replace("10")

        else
          newnumber = @cart.items
          productanditem[1].replace(newnumber)
        @counter = 1
        end

      end
      newpi = productanditem.join("-")
      a.push(newpi)
    end


    else

      a = []
      myproductsarray = @cart.products.split(",")
      myproductsarray.each do |prod|
        productanditem = prod.split("-")
        if productanditem[0] == id.to_s
          newnumber = @cart.items.to_i + productanditem[1].to_i

          if newnumber >= 11
            flash[:danger] = "Die Menge von 10 darf pro Produkt nicht überschritten werden"
            @counter = 2
            productanditem[1].replace("10")

          else
            productanditem[1].replace(newnumber.to_s)
            @counter = 1

          end




        end
        newpi = productanditem.join("-")
        a.push(newpi)
      end

    end

    if @counter == 0
      myproductsarray = @cart.products.split(",")
      a = myproductsarray.push(id + "-" + @cart.items)
    end

    @cart.items = nil
    @cart.products = a.join(",")
    @cart.save

    redirect_to @cart
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def admincheck
      @cart = current_cart

      if current_user.admin?
      elsif current_user.driver? == true or current_customer.id != @cart.customer_id
        redirect_to root_path
        flash[:danger] = "Keine Berechtigung für diese Seite!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:items, :customer_id, :numberofitems, :products, :price)
    end
end
