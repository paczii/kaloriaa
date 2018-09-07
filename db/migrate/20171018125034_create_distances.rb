class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.integer :from_id
      t.integer :to_id
      t.float :traveltime
      t.float :traveldistance

      t.timestamps null: false
    end
  end
end
