class DropAccomodationsCreatePitstops < ActiveRecord::Migration[5.1]
  def change
  	drop_table :accommodations

  	create_table :pitstops do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :price
      t.float :rating
      t.references :end_stage
      t.references :start_stage

      t.timestamps
    end
  end
end
