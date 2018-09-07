class StoresController < ApplicationController
  include StocksHelper

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :admincheck

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        updatestocks_helper

        flash[:success] = "Geschäft erfolgreich erstellt."
        format.html { redirect_to @store}
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        flash[:success] = "Geschäft erfolgreich bearbeitet."

        format.html { redirect_to @store }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    Distance.where(typey: 2, from_id: @store.id).destroy_all
    Distance.where(typey: 3, to_id: @store.id).destroy_all

    @store.destroy
    respond_to do |format|
      flash[:success] = "Geschäft erfolgreich gelöscht."

      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    def admincheck
      if current_user.admin?
      else
        redirect_to root_path
        flash[:danger] = "Keine Berechtigung für diese Seite!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :city, :street, :zip, :concept, :area)
    end
end
