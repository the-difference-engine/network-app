require 'rails_helper'

RSpec.describe AdminsController, :type => :controller do
  login_admin

  it "should have a current_admin" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_admin).to_not eq(nil)
  end

  it "should get new admin form" do
    # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
    # the valid_session overrides the devise login. Remove the valid_session from your specs
    get :new
    expect(response).to be_success
  end
end