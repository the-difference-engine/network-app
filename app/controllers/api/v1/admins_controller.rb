class Api::V1::AdminsController < ApplicationController
  before_action :authenticate_user!

  def index
    @admins = Admin.all
  end
end
