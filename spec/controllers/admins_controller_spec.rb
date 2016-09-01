require 'rails_helper'

RSpec.describe AdminsController, :type => :controller do
  describe 'signed in admin' do
    sign_in_admin

    it "should have a current_admin" do
      expect(subject.current_admin).to_not eq(nil)
    end

    it "should get admin dash" do
      get :admin_center
      expect(response).to be_success
    end
  end
end