class AddAllowEmailsToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :allow_emails, :boolean, default: false
  end
end
