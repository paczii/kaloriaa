class AddStatustypeToOptimizations < ActiveRecord::Migration
  def change
    add_column :optimizations, :statustype, :integer
  end
end
