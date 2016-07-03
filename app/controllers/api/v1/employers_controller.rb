class Api::V1::EmployersController < ApplicationController
  before_action :authenticate_user!

  def index
    @employers = Employer.all
  end
end
