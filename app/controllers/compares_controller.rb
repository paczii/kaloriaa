class ComparesController < ApplicationController
  before_action :set_compare, only: [:show, :edit, :update, :destroy]

  # GET /compares
  # GET /compares.json
  def index
    @compares = Compare.all
  end

  # GET /compares/1
  # GET /compares/1.json
  def show
  end

  # GET /compares/new
  def new
    @compare = Compare.new
  end

  # GET /compares/1/edit
  def edit
  end

  # POST /compares
  # POST /compares.json
  def create
    @compare = Compare.new(compare_params)
    if @compare.opt3 == nil
      @compare.number = 2
    elsif @compare.opt4 == nil
      @compare.number = 3
    elsif @compare.opt5 == nil
      @compare.number = 4
    else
      @compare.number = 5
    end

    respond_to do |format|
      if @compare.save
        format.html { redirect_to @compare, 'data-turbolinks' => false}
        format.json { render :show, status: :created, location: @compare }
      else
        format.html { render :new }
        format.json { render json: @compare.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compares/1
  # PATCH/PUT /compares/1.json
  def update
    respond_to do |format|
      if @compare.update(compare_params)
        format.html { redirect_to @compare, notice: 'Compare was successfully updated.' }
        format.json { render :show, status: :ok, location: @compare }
      else
        format.html { render :edit }
        format.json { render json: @compare.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compares/1
  # DELETE /compares/1.json
  def destroy
    @compare.destroy
    respond_to do |format|
      format.html { redirect_to compares_url, notice: 'Compare was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compare
      @compare = Compare.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compare_params
      params.require(:compare).permit(:number, :opt1, :opt2, :opt3, :opt4, :opt5)
    end
end
