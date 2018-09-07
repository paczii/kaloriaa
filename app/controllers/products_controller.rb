class ProductsController < ApplicationController
  include StocksHelper

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def productslist
    render 'products/productslist'
  end

  def additemtofavs
    productid = params[:myproduct]

    @current_customer = current_customer

    if @current_customer.favorites != nil

    productsarray = @current_customer.favorites.split(",")
    if productsarray.include? productid
      productsarray.delete(productid)
    else
      productsarray.push(productid)

    end

    else
      productsarray = Array.new
      productsarray.push(productid)

    end

    newproductarray = productsarray.join(",")

    @current_customer.favorites = newproductarray

    @current_customer.save

    redirect_to products_path

  end


  def additemtocart
    productid = params[:myproduct]
    size = params[:mysize]


    @cart = current_cart
    @mynewprodctanditems == nil

    newproductanditems = productid + "-" + size
    oldproductsarray = []

    if @cart.products == nil or @cart.products == ""

    else

      # Wenn der Warenkorb bereits Produkte enthält

          oldproductsarray = @cart.products.split(",")

          # jedes bestehende Produkt im Warenkorb wird gesplittet
          oldproductsarray.each do |prod|
            #prod ist jedes einzelne Produkt mit Menge im Warenkorb
            oldproductsid = prod.split("-")
            # Hier wird geprüft ob das Produkt, welches hinzugefügt werden soll, bereits im Warenkorb ist
            # um dann die Menge anzupassen
            if oldproductsid[0] == productid
              newsize = oldproductsid[1].to_i + size.to_i
              if newsize >= 11
                newsize = 10
                    flash[:danger] = "Die Menge von 10 darf pro Produkt nicht überschritten werden."
                flash[:info] = "Die hinzugefügte Menge von " + Product.find(productid).name + " wurde auf 10 gesetzt."
                flash[:success] = Product.find(productid).name + " wurde zum Warenkorb hinzugefügt (Menge: " + newsize.to_s + " )"

                @mynewprodctanditems = productid + "-" + newsize.to_s


              else


                flash[:success] = Product.find(productid).name + " wurde zum Warenkorb hinzugefügt (Menge: " + size + " )"

                @mynewprodctanditems = productid + "-" + newsize.to_s


              end

              oldproductsarray.delete(prod)


            end




            end

    end

    if @mynewprodctanditems == nil
    @mynewprodctanditems = newproductanditems

    end

    oldproductsarray.push(@mynewprodctanditems)

    if Product.find(productid).discountprice != nil
      priceadd = Product.find(productid).discountprice * size.to_f
    else
      priceadd = Product.find(productid).price * size.to_f
    end


    oldprice = @cart.price
    if @cart.price == nil
      oldprice = 0
    end
    @cart.price = oldprice + priceadd
    @cart.products = oldproductsarray.join(",")
    @cart.save


        redirect_to products_path(anchor: "p" + productid.to_s)
  end

  # GET /products
  # GET /products.json
  def index
    cate = params[:category]
    if cate == "Alle Produkte" or cate == nil
      @products = Product.all
    elsif cate == "Angebote"
      @products = Product.where.not(discountprice: nil)
    elsif cate == "Favoriten"
      if current_customer.favorites != nil
      productsarray = current_customer.favorites.split(",")
      @products = Product.where(id: productsarray)
      elsif current_customer.favorites == nil or current_customer.favorites == ""
        @products = Product.all
        flash.now[:danger] = "Sie haben noch keine Favoriten."
      end

    else
    @products = Product.where(category: cate)
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


  def testtest

  redirect_to products_path
  return false
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        updatestocks_helper

        flash[:success] = "Produkt erfolgreich erstellt."

        format.html { redirect_to @product }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        flash[:success] = "Produkt erfolgreich bearbeitet."

        format.html { redirect_to @product }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      flash[:success] = "Produkt erfolgreich gelöscht."

      format.html { redirect_to products_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :brand, :price, :discountprice, :description, :weight, :volume, :vegan, :bio, :picture, :durability, :category)
    end
end
