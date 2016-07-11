require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe AdminsController, :type => :controller do
  describe 'POST #create' do
    before :each do        
      admin = create(:login_admin)
      sign_in_admin(admin)
    end

    context "with valid attributes" do
      it "saves the new admin in the database" do   
        expect {
          post :create, admin: attributes_for(:admin)
        }.to change(Admin, :count).by(1)
      end

      it "redirects to admins#show" do
        post :create, admin: attributes_for(:admin)
        expect(response).to redirect_to admin_path(assigns[:admin])
      end
    end

    context "with invalid attributes" do
      it "does not save the admin in the database" do   
        expect {
          post :create, admin: attributes_for(:invalid_admin)
        }.not_to change(Admin, :count)
      end

      it "re-renders admin :new template" do 
        post :create, admin: attributes_for(:invalid_admin)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do        
      @admin = create(:login_admin, 
        first_name: "John",
        last_name: "Doe"
      )
      sign_in_admin(@admin)
    end

    context "with valid attributes" do
      it "locates the requested @admin" do   
        patch :update, id: @admin, admin: attributes_for(:admin)
        expect(assigns(:admin)).to eq(@admin)
      end

      it "changes @admin's attributes" do
        patch :update, id: @admin, admin: attributes_for(:admin,
          first_name: "Jane",
          last_name: "Doe"
        )
        @admin.reload
        expect(@admin.first_name).to eq("Jane")
        expect(@admin.last_name).to eq("Doe")
      end

      it "redirects to the updates @admin" do
        patch :update, id: @admin, admin: attributes_for(:admin)
        expect(response).to redirect_to admin_center_path
      end
    end

    context "with invalid attributes" do
      it "does not change @admin's attributes" do
        patch :update, id: @admin, admin: attributes_for(:admin,
          first_name: "Jane",
          last_name: nil
        )
        @admin.reload
        expect(@admin.first_name).not_to eq("Jane")
        expect(@admin.last_name).to eq("Doe")
      end

      it "re-renders the admin :edit template " do
        patch :update, id: @admin, admin: attributes_for(:invalid_admin)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do        
      admin = create(:login_admin)
      sign_in_admin(admin)

      @delete_admin = create(:admin)
    end

    it "deletes the admin account" do   
      expect{ delete :destroy, id: @delete_admin}.to change(Admin, :count).by(-1)
    end

    it "deletes the admin account" do   
      delete :destroy, id: @delete_admin
      expect(response).to redirect_to admin_center_path
    end
  end
end