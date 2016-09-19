class CreateBatchInvitations < ActiveRecord::Migration
  def change
    create_table :batch_invitations do |t|
      t.string :unparsed_emails
      t.string :invitee_type
      t.integer :invited_by_id
      t.string :invited_by_type

      t.timestamps null: false
    end
  end
end