class SalaryRangesController < ApplicationController
  before_action :set_salary_range, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index]

  # GET /salary_ranges
  # GET /salary_ranges.json
  def index
    @salary_ranges = SalaryRange.all
    @salary_range = SalaryRange.new
  end

  # GET /salary_ranges/1
  # GET /salary_ranges/1.json
  def show
  end

  # GET /salary_ranges/new
  def new
    @salary_range = SalaryRange.new
  end

  # GET /salary_ranges/1/edit
  def edit
  end

  # POST /salary_ranges
  # POST /salary_ranges.json
  def create
    @salary_range = SalaryRange.new(salary_range_params)

    respond_to do |format|
      if @salary_range.save
        flash[:success] = 'The new salary range/skill was successfully created.'
        format.html { redirect_to salary_ranges_path }
        format.json { render :show, status: :created, location: @salary_range }
      else
        flash[:warning] = 'Unable to add new salary range.'
        format.html { render :index }
        format.json { render json: @salary_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salary_ranges/1
  # PATCH/PUT /salary_ranges/1.json
  def update
    respond_to do |format|
      if @salary_range.update(salary_range_params)
        flash[:success] = 'The salary range was successfully updated.'
        format.html { redirect_to salary_ranges_path }
        format.json { render :show, status: :ok, location: @salary_range }
      else
        flash[:warning] = 'Unable to update salary range.'
        format.html { render :edit }
        format.json { render json: @salary_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salary_ranges/1
  # DELETE /salary_ranges/1.json
  def destroy
    @salary_range.destroy
    respond_to do |format|
      flash[:success] = 'Salary range successfully deleted.'
      format.html { redirect_to salary_ranges_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_range
      @salary_range = SalaryRange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salary_range_params
      params.require(:salary_range).permit(:salary_range)
    end
end
