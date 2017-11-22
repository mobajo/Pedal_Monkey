class ChangeIntegersToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :pitstops, :price, :float
    change_column :stages, :distance, :float
    change_column :stages, :elevation, :float
    change_column :trips, :elevation, :float
    change_column :trips, :distance, :float
  end
end
