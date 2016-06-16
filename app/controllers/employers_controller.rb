class EmployersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create]
  # skip_before_action :require_no_authentication

  def index
    @employers = Employer.all
  end

  def new
    if current_admin
      @employer = Employer.new
    else 
      flash[:warning] = "Access Denied. Admin Only!"
    end
  end

  def create
    @employer = Employer.new(employer_params)

    if @employer.save
      flash[:success] = "Employer account successfully created!"
      redirect_to employer_path(@employer)
    else
      flash[:warning] = "Unable to add new employer"
      render :new
      Rails.logger.info @employer.errors.messages
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
        :state,
        :password,
        :password_confirmation,
        :email
      )
    end

    # def sign_up(resource_name, resource)
    #   true
    # end
end
