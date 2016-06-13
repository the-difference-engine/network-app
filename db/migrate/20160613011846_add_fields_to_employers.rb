class AddFieldsToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :name, :string
    add_column :employers, :image, :string
    add_column :employers, :description, :text
    add_column :employers, :rep_first_name, :string
    add_column :employers, :rep_last_name, :string
    add_column :employers, :rep_phone, :string
    add_column :employers, :rep_email, :string
    add_column :employers, :website, :string
    add_column :employers, :city, :string
    add_column :employers, :state, :string
  end
end
