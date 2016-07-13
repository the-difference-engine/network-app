require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe StudentsController, :type => :controller do
  describe 'POST #create' do
    before :each do        
      admin = create(:login_admin)
      sign_in_admin(admin)
    end

    context "with valid attributes" do
      it "saves the new student in the database" do   
        expect {
          post :create, student: attributes_for(:student)
        }.to change(Student, :count).by(1)
      end

      it "redirects to students#show" do
        post :create, student: attributes_for(:student)
        expect(response).to redirect_to student_path(assigns[:student])
      end
    end

    context "with invalid attributes" do 
      it "does not save the student in the database" do   
        expect {
          post :create, student: attributes_for(:invalid_student)
        }.not_to change(Student, :count)
      end

      it "re-renders student :new template" do 
        post :create, student: attributes_for(:invalid_student)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do        
      @student = create(:login_student, 
        first_name: "Jake",
        last_name: "Arrieta")
      sign_in_student(@student)
    end

    context "with valid attributes" do
      it "locates the requested @student" do   
        patch :update, id: @student, student: attributes_for(:student)
        expect(assigns(:student)).to eq(@student)
      end

      it "changes @student's attributes" do
        patch :update, id: @student, student: attributes_for(:student,
          first_name: "Joseph",
          last_name: "Arrieta"
        )
        @student.reload
        expect(@student.first_name).to eq("Joseph")
        expect(@student.last_name).to eq("Arrieta")
      end

      it "redirects to the updated @student" do
        patch :update, id: @student, student: attributes_for(:student)
        expect(response).to redirect_to student_path(@student)
      end
    end

    context "with invalid attributes" do
      it "does not change @student's attributes" do
        patch :update, id: @student, student: attributes_for(:student,
          first_name: "Joseph",
          email: nil)
        @student.reload
        expect(@student.first_name).not_to eq("Joseph")
        expect(@student.last_name).to eq("Arrieta")
      end

      it "re-renders the student :edit template " do
        patch :update, id: @student, student: attributes_for(:invalid_student)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do        
      admin = create(:login_admin)
      sign_in_admin(admin)
      @delete_student = create(:student)
    end

    it "deletes the student account" do   
      expect{ delete :destroy, id: @delete_student}.to change(Student, :count).by(-1)
    end

    it "redirects to student dash after delete" do   
      delete :destroy, id: @delete_student
      expect(response).to redirect_to admin_center_path
    end
  end
end