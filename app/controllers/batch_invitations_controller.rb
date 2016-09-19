class BatchInvitationsController < ApplicationController
  
  def create
    @batch = BatchInvitation.create(unparsed_emails: params[:email_addresses], invitee_type: params[:type], invited_by_id: current_user.id, invited_by_type: current_user.class)
    Resque.enqueue(BackgroundInvitationEmailer, @batch.id)
    
    redirect_to "/"
  end
end
