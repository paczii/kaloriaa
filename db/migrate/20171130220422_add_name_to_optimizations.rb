class AddNameToOptimizations < ActiveRecord::Migration
  def change
    add_column :optimizations, :name, :string
  end
end
