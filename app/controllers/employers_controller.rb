class EmployersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create]
  before_action :authenticate_admin_employer!, :only => [:edit, :update, :destroy]
  # skip_before_action :require_no_authentication

  def index
    @employers = Employer.all
  end

  def new
    @employer = Employer.new
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
    @follow_up_list = @employer.follow_up_list
  end

  def edit
    @employer = Employer.find(params[:id])
    unless admin_signed_in? || employer_signed_in? && @employer.id == current_employer.id
      redirect_to employers_path
      flash[:warning] = "You do not have access to that page!"
    end
  end

  def update
    @employer = Employer.find(params[:id])

    if @employer.update(employer_params)
      flash[:success] = "Employer account successfully updated!"
      redirect_to employer_path(@employer)
    else
      flash[:warning] = "Unable to update employer account!"
      render :edit
      Rails.logger.info @employer.errors.messages
    end
  end

  def destroy  
    @employer = Employer.find(params[:id]) 

    if @employer.destroy
      flash[:success] = "Employer account successfully deleted!"
      redirect_to employers_path
    else
      flash[:warning] = "Unable to delete the employer"
      Rails.logger.info @employer.errors.messages
    end 
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
        # :current_password,
        :email
      )
    end

    # def sign_up(resource_name, resource)
    #   true
    # end
end
