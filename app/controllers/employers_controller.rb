class EmployersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @employers = Employer.all
  end

  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new

    if @employer.save
      redirect_to :show
    else
      render :new
    end
  end

  def show
    @employer = Employer.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy  
    @employer = Employer.find(params[:id])  
  end

  private

    def employer_params
      params.require(:employer).permit(
        :name,
        :image,
        :description,
        :rep_first_name,
        :rep_last_name,
        :rep_phone,
        :rep_email,
        :website,
        :city,
        :state
      )
    end
end
