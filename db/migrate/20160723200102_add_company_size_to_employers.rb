class AddCompanySizeToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :company_size, :integer
  end
end
