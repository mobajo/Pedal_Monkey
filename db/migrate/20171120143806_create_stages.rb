class CreateStages < ActiveRecord::Migration[5.1]
  def change
    create_table :stages do |t|
      t.string :startpoint_address
      t.float :startpoint_latitude
      t.float :startpoint_longitude
      t.string :endpoint_address
      t.float :endpoint_latitude
      t.float :endpoint_longitude
      t.integer :stage_no
      t.integer :distance
      t.integer :elevation
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
