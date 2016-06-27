class AdminsController < ApplicationController
  include DeviseInvitable::Inviter
  
  before_action :authenticate_admin!

  
  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      flash[:success] = "Admin account successfully created!"
      redirect_to admin_path(@admin)
    else
      flash[:warning] = "Unable to add new admin."
      render :new
    end
  end

  def show
    @admin = Admin.find(params[:id])
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
        format.html { redirect_to admins_path }
        flash[:success] = "Your account was successfully updated!"
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.remove_avatar!
    @admin.save

    if @admin.destroy
      flash[:success] = "Admin account successfully deleted!"
      redirect_to admins_path
    else
      flash[:warning] = "Unable to delete the admin account."
      Rails.logger.info @admin.errors.messages
    end 
  end

  def admin_center
    @employers = Employer.all
    @students = Student.all
  end

  private

    def admin_params
      params.require(:admin).permit(
        :first_name, 
        :last_name,
        :avatar,
        :email,
        :password,
        :password_confirmation
      )
    end

    def needs_password?(user, params)
      params[:password].present?
    end

end
