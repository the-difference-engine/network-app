require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe EmployersController, :type => :controller do
  describe 'POST #create' do
    before :each do        
      admin = create(:login_admin)
      sign_in_admin(admin)
    end

    context "with valid attributes" do
      it "saves the new employer in the database" do   
        expect {
          post :create, employer: attributes_for(:employer)
        }.to change(Employer, :count).by(1)
      end

      it "redirects to employers#show" do
        post :create, employer: attributes_for(:employer)
        expect(response).to redirect_to employer_path(assigns[:employer])
      end
    end

    context "with invalid attributes" do
      it "does not save the employer in the database" do   
        expect {
          post :create, employer: attributes_for(:invalid_employer)
        }.not_to change(Employer, :count)
      end

      it "re-renders employer :new template" do 
        post :create, employer: attributes_for(:invalid_employer)
        expect(response).to render_template :new
      end
    end
  end 
end