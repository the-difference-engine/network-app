class CreateFollowUpLists < ActiveRecord::Migration
  def change
    create_table :follow_up_lists do |t|
      t.integer :employer_id
      t.string :name

      t.timestamps 
    end
  end
end
