class SalaryRangesController < ApplicationController
  before_action :set_salary_range, only: [:show, :edit, :update, :destroy]

  # GET /salary_ranges
  # GET /salary_ranges.json
  def index
    @salary_ranges = SalaryRange.all
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
        format.html { redirect_to @salary_range, notice: 'Salary range was successfully created.' }
        format.json { render :show, status: :created, location: @salary_range }
      else
        format.html { render :new }
        format.json { render json: @salary_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salary_ranges/1
  # PATCH/PUT /salary_ranges/1.json
  def update
    respond_to do |format|
      if @salary_range.update(salary_range_params)
        format.html { redirect_to @salary_range, notice: 'Salary range was successfully updated.' }
        format.json { render :show, status: :ok, location: @salary_range }
      else
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
      format.html { redirect_to salary_ranges_url, notice: 'Salary range was successfully destroyed.' }
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
