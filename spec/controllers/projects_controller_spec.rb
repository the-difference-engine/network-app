require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  context "when student is signed in " do
    sign_in_student

    it "should have a current_student" do
      expect(subject.current_student).to_not eq(nil)
    end

    it "should have @student = current_student" do
      expect(subject.current_student).to eq(@student)
    end
  end
end