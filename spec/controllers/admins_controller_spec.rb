require 'rails_helper'

RSpec.describe AdminsController, :type => :controller do
  context "when admin is signed in " do
    sign_in_admin

    it "should have a current_admin" do
      expect(subject.current_admin).to_not eq(nil)
    end

    it "should go to admin dash /dashboard, success status" do
      get :admin_center
      expect(response).to be_success
    end
  end

  context "when admin is not signed in " do
    it "should not have a current_admin" do
      expect(subject.current_admin).to eq(nil)
    end

    it "should redirect to /sign_in" do
      get :admin_center
      expect(response).to redirect_to home_sign_in_path
    end
  end

  context "when student is signed in " do
    sign_in_student

    it "should redirect to /sign_in" do
      get :admin_center
      expect(response).to redirect_to students_path
    end
  end

  context "when student is signed in " do
    sign_in_employer

    it "should redirect to /sign_in" do
      get :admin_center
      expect(response).to redirect_to students_path
    end
  end
end