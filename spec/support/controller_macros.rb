module ControllerMacros
  def sign_in_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = FactoryGirl.create(:login_admin) # Using factory girl as an example
      sign_in @admin
    end
  end

  def sign_in_student
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:student] 
      @student = FactoryGirl.create(:login_student) # Using factory girl as an example
      sign_in @student
    end
  end 

  def sign_in_employer
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:employer] 
      @employer = FactoryGirl.create(:login_employer) # Using factory girl as an example
      sign_in @employer
    end
  end 
end