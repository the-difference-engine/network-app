require 'rails_helper'

RSpec.describe EmployersController, :type => :controller do
  context "when employer is signed in " do
    sign_in_employer

    it "should have a current_employer" do
      expect(subject.current_employer).to_not eq(nil)
    end

    it "should have @employer = current_employer" do
      expect(subject.current_employer).to eq(@employer)
    end

    it "should go to /employers, success status" do
      get :index
      expect(response).to be_success
    end
  end

  context "when employer is not signed in " do
    it "should not have a current_employer" do
      expect(subject.current_employer).to eq(nil)
    end

    it "should redirect to /sign_in" do
      get :index
      expect(response).to redirect_to home_sign_in_path
    end
  end

  describe 'POST #create' do
    context "when admin is signed in and valid employer attributes" do
      sign_in_admin

      it "should save the new employer in the database" do   
        expect {
          post :create, employer: attributes_for(:employer)
        }.to change(Employer, :count).by(1)
      end

      it "should redirect to employers#show" do
        post :create, employer: attributes_for(:employer)
        expect(response).to redirect_to employer_path(assigns[:employer])
      end
    end

    context "when admin is signed in and invalid employer attributes" do 
      sign_in_admin

      it "should not save the employer in the database" do   
        expect {
          post :create, employer: attributes_for(:invalid_employer)
        }.not_to change(Employer, :count)
      end

      it "should re-render employer :new template" do 
        post :create, employer: attributes_for(:invalid_employer)
        expect(response).to render_template :new
      end
    end

    context "when admin is not signed in" do
      it "should not save the new employer in the database" do   
        expect {
          post :create, employer: attributes_for(:employer)
        }.to change(Employer, :count).by(0)
      end

      it "should redirect to /sign_in" do
        post :create, employer: attributes_for(:employer)
        expect(response).to redirect_to home_sign_in_path
      end
    end

    context "when employer is signed in" do
      sign_in_employer

      it "should not save the new employer in the database" do   
        expect {
          post :create, employer: attributes_for(:employer)
        }.to change(Employer, :count).by(0)
      end

      it "should redirect to /students" do
        post :create, employer: attributes_for(:employer)
        expect(response).to redirect_to students_path
      end
    end
  end

  describe 'PATCH #update' do  
    sign_in_employer

    it "should locate the signed in @employer" do   
      get :update, id: @employer, employer: attributes_for(:employer)
      expect(assigns(:employer)).to eq(@employer)
    end

    context "when employer is signed in with valid @employer attributes" do
      it "should change @employer's attributes" do
        patch :update, id: @employer, employer: attributes_for(:employer,
          name: "Cubs",
          rep_first_name: "Joe"
        )
        @employer.reload
        expect(@employer.name).to eq("Cubs")
        expect(@employer.rep_first_name).to eq("Joe")
      end

      it "should redirect to the updated @employer" do
        patch :update, id: @employer, employer: attributes_for(:employer)
        expect(response).to redirect_to employer_path(@employer)
      end
    end

    context "when employer is signed in with invalid @employer attributes" do
      it "should not change @employer's attributes" do
        patch :update, id: @employer, employer: attributes_for(:employer,
          name: "Cardinals",
          email: nil
        )
        @employer.reload
        expect(@employer.name).not_to eq("Cardinals")
        expect(@employer.email).to eq("employer_login@gmail.com")
      end

      it "should re-render the employer :edit template " do
        patch :update, id: @employer, employer: attributes_for(:invalid_employer)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_admin
    
    context "when admin is signed in" do

      before :each do        
        @delete_employer = create(:employer)
      end

      it "should allow admin to delete the employer account" do   
        expect{ delete :destroy, id: @delete_employer}.to change(Employer, :count).by(-1)
      end

      it "should redirect to root path" do   
        delete :destroy, id: @delete_employer
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when admin is not signed in" do
      before :each do        
        @delete_employer = create(:employer)
      end

      it "should not allow user to delete the employer account" do   
        expect{ delete :destroy, id: @delete_employer}.to change(Employer, :count).by(0)
      end

      it "should redirect to /sign_in" do   
        delete :destroy, id: @delete_employer
        expect(response).to redirect_to home_sign_in_path
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_employer

    context "when employer is signed in to delete own account" do

      it "should allow employer to delete own account" do   
        expect{ delete :destroy, id: @employer}.to change(Employer, :count).by(-1)
      end

      it "should redirect to root path" do   
        delete :destroy, id: @employer
        expect(response).to redirect_to root_path
      end
    end

    context "when employer is signed in to delete another's account" do
      before :each do        
        @delete_employer = create(:employer)
      end

      it "should not allow employer to delete another's employer account" do   
        expect{ delete :destroy, id: @delete_employer}.to change(Employer, :count).by(0)
      end

      it "should redirect to root path" do   
        delete :destroy, id: @delete_employer
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_student

    context "when student is signed in" do
      before :each do        
        @delete_employer = create(:employer)
      end

      it "should not allow student to delete an employer account" do   
        expect{ delete :destroy, id: @delete_employer}.to change(Employer, :count).by(0)
      end

      it "should redirect to students path" do   
        delete :destroy, id: @delete_employer
        expect(response).to redirect_to students_path
      end
    end
  end
end