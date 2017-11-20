class CreateAccommodations < ActiveRecord::Migration[5.1]
  def change
    create_table :accommodations do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :price
      t.float :rating
      t.references :stage, foreign_key: true

      t.timestamps
    end
  end
end
