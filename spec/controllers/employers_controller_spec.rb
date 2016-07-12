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

  describe 'PATCH #update' do
    before :each do        
      @employer = create(:login_employer, 
        name: "Cubs",
        city: "Chicago")
      sign_in_employer(@employer)
    end

    context "with valid attributes" do
      it "locates the requested @employer" do   
        patch :update, id: @employer, employer: attributes_for(:employer)
        expect(assigns(:employer)).to eq(@employer)
      end

      it "changes @employer's attributes" do
        patch :update, id: @employer, employer: attributes_for(:employer,
          name: "Cubbies",
          city: "Chicago"
        )
        @employer.reload
        expect(@employer.name).to eq("Cubbies")
      end

      it "redirects to the updated @employer" do
        patch :update, id: @employer, employer: attributes_for(:employer)
        expect(response).to redirect_to employer_path(@employer)
      end
    end

    context "with invalid attributes" do
      it "does not change @employer's attributes" do
        patch :update, id: @employer, employer: attributes_for(:employer,
          name: nil,
          city: "Miami")
        @employer.reload
        expect(@employer.name).to eq("Cubs")
        expect(@employer.city).not_to eq("Miami")
      end

      it "re-renders the employer :edit template " do
        patch :update, id: @employer, employer: attributes_for(:invalid_employer)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do        
      admin = create(:login_admin)
      sign_in_admin(admin)
      @delete_employer = create(:employer)
    end

    it "deletes the employer account" do   
      expect{ delete :destroy, id: @delete_employer}.to change(Employer, :count).by(-1)
    end

    # it "redirects to admin dash after delete" do   
    #   delete :destroy, id: @delete_employer
    #   expect(response).to redirect_to employer_center_path
    # end
  end 
end