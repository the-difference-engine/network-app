class Students::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :authenticate_admin_student!, except: [:new, :create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # # PUT /resource
  # def update
  #   super
  # end

  # # DELETE /resource
  # def destroy
  #   super
  # end

  # # GET /resource/cancel
  # # Forces the session data which is usually expired after sign
  # # in to be expired now. This is useful if the user wants to
  # # cancel oauth signing in/up in the middle of the process,
  # # removing all OAuth session data.
  # def cancel
  #   super
  # end

 protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << 
      [ :first_name, 
        :last_name,
        :avatar,
        :city,
        :current_city,
        :current_state,
        :industry,
        :grad_date,
        :skill_1,
        :skill_2,
        :skill_3,
        :interest_1,
        :interest_2,
        :interest_3,
        :interview_1,
        :interview_2,
        :interview_3,
        :github,
        :blog,
        :linked_in,
        :quote,
        :seeking_employment,
        :resume,
        :follow_up_list_id,
        :email,
        :password,
        :password_confirmation
      ]
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:account_update) << 
      [ :first_name, 
        :last_name,
        :avatar,
        :city,
        :current_city,
        :current_state,
        :industry,
        :grad_date,
        :skill_1,
        :skill_2,
        :skill_3,
        :interest_1,
        :interest_2,
        :interest_3,
        :interview_1,
        :interview_2,
        :interview_3,
        :github,
        :blog,
        :linked_in,
        :quote,
        :seeking_employment,
        :resume,
        :follow_up_list_id,
        :email,
        :password,
        :password_confirmation
      ]
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
