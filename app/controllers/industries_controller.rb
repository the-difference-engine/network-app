class IndustriesController < ApplicationController
  before_action :set_industry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index]

  # GET /industries
  # GET /industries.json
  def index
    @industries = Industry.all
    @industry = Industry.new
  end

  # GET /industries/1
  # GET /industries/1.json
  def show
  end

  # GET /industries/new
  def new
    @industry = Industry.new
  end

  # GET /industries/1/edit
  def edit
  end

  # POST /industries
  # POST /industries.json
  def create
    @industry = Industry.new(industry_params)

    respond_to do |format|
      if @industry.save
        flash[:success] = 'The new industry was successfully created.'
        format.html { redirect_to industries_path }
        format.json { render :show, status: :created, location: @industry }
      else
        flash[:warning] = 'Unable to add new industry.'
        format.html { render :index }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /industries/1
  # PATCH/PUT /industries/1.json
  def update
    respond_to do |format|
      if @industry.update(industry_params)
        flash[:success] = 'The industry was successfully updated.'
        format.html { redirect_to industries_path }
        format.json { render :show, status: :ok, location: @industry }
      else
        flash[:warning] = 'Unable to update industry.'
        format.html { render :edit }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /industries/1
  # DELETE /industries/1.json
  def destroy
    @industry.destroy
    respond_to do |format|
      flash[:success] = 'Industry successfully deleted.'
      format.html { redirect_to industries_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_industry
      @industry = Industry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def industry_params
      params.require(:industry).permit(:name)
    end
end
