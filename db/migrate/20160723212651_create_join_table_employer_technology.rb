class CreateJoinTableEmployerTechnology < ActiveRecord::Migration
  def change
    create_join_table :employers, :technologies do |t|
      # t.index [:employer_id, :technology_id]
      # t.index [:technology_id, :employer_id]
    end
  end
end
