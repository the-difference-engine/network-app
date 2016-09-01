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

    context "when admin is signed in and invalid admin attributes" do 
      sign_in_admin

      it "should not save the admin in the database" do   
        expect {
          post :create, admin: attributes_for(:invalid_admin)
        }.not_to change(Admin, :count)
      end

      it "should re-render admin :new template" do 
        post :create, admin: attributes_for(:invalid_admin)
        expect(response).to render_template :new
      end
    end

    context "when admin is not signed in" do
      it "should not save the new admin in the database" do   
        expect {
          post :create, admin: attributes_for(:admin)
        }.to change(Admin, :count).by(0)
      end

      it "should redirect to /sign_in" do
        post :create, admin: attributes_for(:admin)
        expect(response).to redirect_to home_sign_in_path
      end
    end
  end

  describe 'PATCH #update' do  
    sign_in_admin

    it "should locate the signed in @admin" do   
      get :update, id: @admin, admin: attributes_for(:admin)
      expect(assigns(:admin)).to eq(@admin)
    end

    context "when admin is signed in with valid @admin attributes" do
      it "should change @admin's attributes" do
        patch :update, id: @admin, admin: attributes_for(:admin,
          first_name: "Jacob",
          last_name: "Arrieta"
        )
        @admin.reload
        expect(@admin.first_name).to eq("Jacob")
        expect(@admin.last_name).to eq("Arrieta")
      end

      it "should redirect to the updated @admin" do
        patch :update, id: @admin, admin: attributes_for(:admin)
        expect(response).to redirect_to admin_center_path
      end
    end

    context "when admin is signed in with invalid @admin attributes" do
      it "should not change @admin's attributes" do
        patch :update, id: @admin, admin: attributes_for(:admin,
          first_name: "Jacob",
          email: nil)
        @admin.reload
        expect(@admin.first_name).not_to eq("Jacob")
        expect(@admin.email).to eq("admin_login@gmail.com")
      end

      it "should re-render the admin :edit template " do
        patch :update, id: @admin, admin: attributes_for(:invalid_admin)
        expect(response).to render_template :edit
      end
    end
  end
end