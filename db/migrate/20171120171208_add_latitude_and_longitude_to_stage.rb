class AddLatitudeAndLongitudeToStage < ActiveRecord::Migration[5.1]
  def change
    add_column :stages, :latitude, :float
    add_column :stages, :longitude, :float
  end
end
