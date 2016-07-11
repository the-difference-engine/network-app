require 'rails_helper'


RSpec.describe AdminsController, :type => :controller do
  describe 'POST #create' do
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
 
      it "re-renders admins :new template" do 
        post :create, admin: attributes_for(:invalid_admin)
        expect(response).to render_template :new
      end
    end
  end
end