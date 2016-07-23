class EmployersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, :only => [:new, :create]
  before_action :authenticate_admin_employer!, :only => [:edit, :update, :destroy]
  
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
      flash[:warning] = "Unable to add new employer."
      render :new
    end
  end

  def show
    @employer = Employer.find(params[:id])
    @follow_up_list = @employer.follow_up_list
    @positions = @employer.positions if @employer.positions.any?
    @position_types = @employer.position_types if @employer.position_types.any?
    @industries = @employer.industries if @employer.industries.any?
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

    # Allow employer account update without password
    if admin_signed_in? || employer_signed_in? && @employer.id == current_employer.id
      if employer_params[:password].blank?
        employer_params.delete(:password)
        employer_params.delete(:password_confirmation)
      end

      successfully_updated = if needs_password?(@employer, employer_params)
                               @employer.update(employer_params)
                             else
                               @employer.update_without_password(employer_params)
                             end

      respond_to do |format|
        if successfully_updated
          format.html { redirect_to @employer }
          flash[:success] = "Your account was successfully updated!"
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          flash[:warning] = "Unable to update your account."
          format.json { render json: @employer.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to employers_path
      flash[:warning] = "You do not have access to that page!"
    end
  end

  def destroy  
    @employer = Employer.find(params[:id])
    @employer.remove_image!
    @employer.save

    if @employer.destroy
      flash[:success] = "Employer account successfully deleted!"
      redirect_to admin_center_path
    else
      flash[:warning] = "Unable to delete the employer account."
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
        :email,
        :currently_hiring,
        :hiring_timeline,
        :number_of_positions,
        position_ids: [],
        position_type_ids: [],
        industry_ids: []
      )
    end

    def needs_password?(user, params)
      params[:password].present?
    end
end
