class ChangeCompanySizeToStringInEmployers < ActiveRecord::Migration
  def change
    change_column :employers, :company_size, :string
  end
end
