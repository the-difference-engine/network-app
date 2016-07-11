require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe AdminsController, :type => :controller do
  describe 'POST #create' do
    before :each do        
      user = create(:admin)
      sign_in user
    end

    context "with valid attributes" do
      it "saves the new admin in the database" do   
        expect {
          post :create, admin: attributes_for(:admin, email: "test@gmail.com")
        }.to change(Admin, :count).by(1)
      end

      it "redirects to admins#show" do
        post :create, admin: attributes_for(:admin, email: "test@gmail.com")
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