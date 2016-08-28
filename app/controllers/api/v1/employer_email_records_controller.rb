class Api::V1::EmployerEmailRecordsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employer_email_records = EmployerEmailRecord.all
  end
end
