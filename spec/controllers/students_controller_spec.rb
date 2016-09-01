require 'rails_helper'

RSpec.describe StudentsController, :type => :controller do
  describe 'student signed in' do
    sign_in_student

    it "should have a current_student" do
      expect(subject.current_student).to_not eq(nil)
    end

    it "should have @student = current_student" do
      expect(subject.current_student).to eq(@student)
    end

    it "should go to /students, success status" do
      get :index
      expect(response).to be_success
    end
  end

  describe 'student not signed in' do
    it "should not have a current_student" do
      expect(subject.current_student).to eq(nil)
    end

    it "should redirect to /sign_in" do
      get :index
      expect(response).to redirect_to home_sign_in_path
    end
  end

  describe 'POST #create' do
    context "with signed in admin and valid student attributes" do
      sign_in_admin

      it "should save the new student in the database" do   
        expect {
          post :create, student: attributes_for(:student)
        }.to change(Student, :count).by(1)
      end

      it "should redirect to students#show" do
        post :create, student: attributes_for(:student)
        expect(response).to redirect_to student_path(assigns[:student])
      end
    end

    context "with signed in admin and invalid student attributes" do 
      sign_in_admin

      it "should not save the student in the database" do   
        expect {
          post :create, student: attributes_for(:invalid_student)
        }.not_to change(Student, :count)
      end

      it "should re-render student :new template" do 
        post :create, student: attributes_for(:invalid_student)
        expect(response).to render_template :new
      end
    end

    context "with no signed in admin and valid student attributes" do
      it "should not save the new student in the database" do   
        expect {
          post :create, student: attributes_for(:student)
        }.to change(Student, :count).by(0)
      end

      it "should redirect to /sign_in" do
        post :create, student: attributes_for(:student)
        expect(response).to redirect_to home_sign_in_path
      end
    end
  end

  describe 'PATCH #update' do  
    sign_in_student

    it "should locate the signed in @student" do   
      get :update, id: @student, student: attributes_for(:student)
      expect(assigns(:student)).to eq(@student)
    end

    context "with valid @student attributes" do
      it "should change @student's attributes" do
        patch :update, id: @student, student: attributes_for(:student,
          first_name: "Jacob",
          last_name: "Arrieta"
        )
        @student.reload
        expect(@student.first_name).to eq("Jacob")
        expect(@student.last_name).to eq("Arrieta")
      end

      it "should redirect to the updated @student" do
        patch :update, id: @student, student: attributes_for(:student)
        expect(response).to redirect_to student_path(@student)
      end
    end

    context "with invalid @student attributes" do
      it "should not change @student's attributes" do
        patch :update, id: @student, student: attributes_for(:student,
          first_name: "Jacob",
          email: nil)
        @student.reload
        expect(@student.first_name).not_to eq("Jacob")
        expect(@student.email).to eq("student_login@gmail.com")
      end

      it "should re-render the student :edit template " do
        patch :update, id: @student, student: attributes_for(:invalid_student)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when admin is signed in" do
      sign_in_admin

      before :each do        
        @delete_student = create(:student)
      end

      it "deletes the student account" do   
        expect{ delete :destroy, id: @delete_student}.to change(Student, :count).by(-1)
      end

      it "redirects to admin dash after delete" do   
        delete :destroy, id: @delete_student
        expect(response).to redirect_to admin_center_path
      end
    end

    context "when admin is not signed in" do
      before :each do        
        @delete_student = create(:student)
      end

      it "deletes the student account" do   
        expect{ delete :destroy, id: @delete_student}.to change(Student, :count).by(0)
      end

      it "redirects to /sign_in" do   
        delete :destroy, id: @delete_student
        expect(response).to redirect_to home_sign_in_path
      end
    end
  end
end