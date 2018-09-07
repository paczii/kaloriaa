class CreateCompares < ActiveRecord::Migration
  def change
    create_table :compares do |t|
      t.integer :number
      t.integer :opt1
      t.integer :opt2
      t.integer :opt3
      t.integer :opt4
      t.integer :opt5

      t.timestamps null: false
    end
  end
end
