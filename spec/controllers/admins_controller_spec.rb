require 'rails_helper'

RSpec.describe AdminsController, :type => :controller do
  # describe "anonymous user" do
  #   before :each do
  #     # This simulates an anonymous user
  #     login_with nil
  #   end

  #   it "should be redirected to sign in" do
  #     get :new
  #     expect( response ).to redirect_to( home_sign_in_path )
  #   end
  # end

  # describe "logged in admin" do
  #   before :each do
  #     # This simulates an anonymous user
  #     login_with
  #   end

  #   it "should render admin new, status success" do
  #     get :new
  #     expect( response ).to be_success
  #   end

  #   it "should render admin dash, status success" do
  #     get :admin_center
  #     expect( response ).to be_success
  #   end
  # end

  describe AdminsController do
    login_admin

    it "should have a current_user" do
      # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
      expect(subject.current_user).to_not eq(nil)
    end

    it "should get new admin page" do
      # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
      # the valid_session overrides the devise login. Remove the valid_session from your specs
      get 'new'
      response.should be_success
    end
  end
end