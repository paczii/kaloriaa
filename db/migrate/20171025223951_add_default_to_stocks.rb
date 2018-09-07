class AddDefaultToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :default, :integer
  end
end
