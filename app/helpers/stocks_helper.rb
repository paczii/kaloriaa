module StocksHelper

  def updatestocks_helper
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

  end



  def resetstocks_helper
    @products = Product.all
    @stores = Store.all


    @products.each do |product|

      @stores.each do |store|


        @stock = Stock.find_by_product_id_and_store_id(product.id, store.id)

          @stock.stock = [true, true, true, true, true, false].sample
          @stock.save





      end

    end

  end

end
