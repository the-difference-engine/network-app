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
end