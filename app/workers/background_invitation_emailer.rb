class BackgroundInvitationEmailer
  @queue = :invitations_queue

  def self.perform(batch_id)
    invite_job = BatchInvitation.find(batch_id)
    batch = invite_job.unparsed_emails
    user_type = invite_job.invitee_type.capitalize.constantize

    batch.split(",").each do |unparsed_email|
      if parsed_email = EmailAddress.new(unparsed_email).parse_email
        unless user_type.find_by(email: parsed_email.to_s)
          user_type.create(:email => parsed_email, :invited_by_id => invite_job.invited_by_id, :invited_by_type => invite_job.invited_by_type).invite!
        end
      end
    end

  end
end