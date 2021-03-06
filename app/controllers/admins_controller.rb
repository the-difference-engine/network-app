class AdminsController < ApplicationController
  include DeviseInvitable::Inviter 
  before_action :authenticate_admin!

  def index
    @admins = Admin.where(active: true).order(:last_name)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      flash[:success] = "Admin account successfully created!"
      redirect_to admin_center_path
    else
      Rails.logger.info @admin.attributes
      render :new
    end
  end

  def batch
    render 'admins/invitations/batch'
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])

    # Allow admin account update without password
    if admin_params[:password].blank?
      admin_params.delete(:password)
      admin_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@admin, admin_params)
                             @admin.update(admin_params)
                           else
                             @admin.update_without_password(admin_params)
                           end
    respond_to do |format|
      if successfully_updated
        sign_in(@admin, :bypass => true)
        format.html { redirect_to admin_center_path }
        flash[:success] = "The account was successfully updated!"
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admins.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.remove_avatar!
    @admin.save

    if @admin.destroy
      flash[:success] = "Admin account successfully deleted!"
      redirect_to admin_center_path
    else
      flash[:warning] = "Unable to delete the admin account."
      Rails.logger.info @admin.errors.messages
    end
  end

  def admin_center
    @students = Student.where(active: true).order(:first_name)
    @employers = Employer.where(active: true).order(:name)
    @admins = Admin.where(active: true).order(:first_name)
    @pending_invites = Employer.where(active: false) + Student.where(active: false) + Admin.where(active: false)
    @employer_emails = EmployerEmailRecord.all
    @student_emails = StudentEmailRecord.all
  end

  private

    def admin_params
      params.require(:admin).permit(
        :first_name,
        :last_name,
        :avatar,
        :remove_avatar,
        :active,
        :hide_profile,
        :email,
        :password,
        :password_confirmation
      )
    end

    def needs_password?(user, params)
      params[:password].present?
    end
end
