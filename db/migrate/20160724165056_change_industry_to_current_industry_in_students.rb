class ChangeIndustryToCurrentIndustryInStudents < ActiveRecord::Migration
  def change
    rename_column :students, :industry, :current_industry
  end
end
