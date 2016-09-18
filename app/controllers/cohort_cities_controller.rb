class CohortCitiesController < ApplicationController
  before_action :set_cohort_city, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index]

  # GET /cohort_cities
  # GET /cohort_cities.json
  def index
    @cohort_cities = CohortCity.all.order(:name)
    @cohort_city = CohortCity.new
  end

  # GET /cohort_cities/1
  # GET /cohort_cities/1.json
  def show
  end

  # GET /cohort_cities/new
  def new
    @cohort_city = CohortCity.new
  end

  # GET /cohort_cities/1/edit
  def edit
  end

  # POST /cohort_cities
  # POST /cohort_cities.json
  def create
    @cohort_city = CohortCity.new(cohort_city_params)

    respond_to do |format|
      if @cohort_city.save
        flash[:success] = 'The new cohort_city/skill was successfully created.'
        format.html { redirect_to cohort_cities_path }
        format.json { render :show, status: :created, location: @cohort_city }
      else
        flash[:warning] = 'Unable to add new cohort_city.'
        format.html { render :index }
        format.json { render json: @cohort_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cohort_cities/1
  # PATCH/PUT /cohort_cities/1.json
  def update
    respond_to do |format|
      if @cohort_city.update(cohort_city_params)
        flash[:success] = 'The cohort city was successfully updated.'
        format.html { redirect_to cohort_cities_path }
        format.json { render :show, status: :ok, location: @cohort_city }
      else
        flash[:warning] = 'Unable to update cohort city.'
        format.html { render :edit }
        format.json { render json: @cohort_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cohort_cities/1
  # DELETE /cohort_cities/1.json
  def destroy
    @cohort_city.destroy
    respond_to do |format|
      flash[:success] = 'cohort city successfully deleted.'
      format.html { redirect_to cohort_cities_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cohort_city
      @cohort_city = CohortCity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cohort_city_params
      params.require(:cohort_city).permit(:name)
    end
end
