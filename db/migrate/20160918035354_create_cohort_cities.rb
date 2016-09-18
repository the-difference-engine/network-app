class CreateCohortCities < ActiveRecord::Migration
  def change
    create_table :cohort_cities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
