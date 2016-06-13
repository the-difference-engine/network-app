class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:sign_in]
  
  def sign_in
  end
end
