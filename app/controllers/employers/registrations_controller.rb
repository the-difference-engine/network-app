class Employers::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :authenticate_admin_employer!, except: [:new, :create]
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # # POST /resource
  # def create
  #   super
  # end

  # # GET /resource/edit
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

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) <<
        [ :name,
          :image,
          :remove_image,
          :description,
          :rep_first_name,
          :rep_last_name,
          :rep_phone,
          :rep_email,
          :website,
          :city,
          :state,
          :currently_hiring,
          :hiring_timeline,
          :number_of_positions,
          :company_size,
          :active,
          :hide_profile,
          :allow_emails,
          :sign_up_code,
          :password,
          :password_confirmation,
          :email,
          position_ids: [],
          position_type_ids: [],
          industry_ids: [],
          salary_range_ids: [],
          technology_ids: []
        ]
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) << 
        [ :name,
          :image,
          :remove_image,
          :description,
          :rep_first_name,
          :rep_last_name,
          :rep_phone,
          :rep_email,
          :website,
          :city,
          :state,
          :currently_hiring,
          :hiring_timeline,
          :number_of_positions,
          :company_size,
          :active,
          :hide_profile,
          :allow_emails,
          :sign_up_code,
          :password,
          :password_confirmation,
          :current_password,
          :email,
          position_ids: [],
          position_type_ids: [],
          industry_ids: [],
          salary_range_ids: [],
          technology_ids: []
        ]
    end

  # private

  #   def sign_up(resource_name, resource)
  #     true
  #   end


  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
