module ControllerHelpers
  def sign_in_admin(admin)
    if admin.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :admin})
      allow(controller).to receive(:current_admin).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
  end

  def sign_in_employer(employer)
    if employer.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :employer})
      allow(controller).to receive(:current_employer).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(employer)
      allow(controller).to receive(:current_employer).and_return(employer)
    end
  end
end