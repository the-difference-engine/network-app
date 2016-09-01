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

  context "when employer is signed in " do
    sign_in_employer

    it "should redirect to /sign_in" do
      get :admin_center
      expect(response).to redirect_to students_path
    end
  end

  describe 'POST #create' do
    context "when admin is signed in and valid admin attributes" do
      sign_in_admin

      it "should save the new admin in the database" do   
        expect {
          post :create, admin: attributes_for(:admin)
        }.to change(Admin, :count).by(1)
      end

      it "should redirect to admins#admin_center" do
        post :create, admin: attributes_for(:admin)
        expect(response).to redirect_to admin_center_path
      end
    end

    # context "when admin is signed in and invalid student attributes" do 
    #   sign_in_admin

    #   it "should not save the student in the database" do   
    #     expect {
    #       post :create, student: attributes_for(:invalid_student)
    #     }.not_to change(Student, :count)
    #   end

    #   it "should re-render student :new template" do 
    #     post :create, student: attributes_for(:invalid_student)
    #     expect(response).to render_template :new
    #   end
    # end

    # context "when admin is not signed in" do
    #   it "should not save the new student in the database" do   
    #     expect {
    #       post :create, student: attributes_for(:student)
    #     }.to change(Student, :count).by(0)
    #   end

    #   it "should redirect to /sign_in" do
    #     post :create, student: attributes_for(:student)
    #     expect(response).to redirect_to home_sign_in_path
    #   end
    # end
  end
end