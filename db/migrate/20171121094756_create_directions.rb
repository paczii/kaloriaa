class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.integer :optimization_id
      t.integer :from
      t.integer :to
      t.integer :by

      t.timestamps null: false
    end
  end
end
