class CreateAccomodations < ActiveRecord::Migration[5.1]
  def change
    create_table :accomodations do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :price
      t.integer :rating
      t.references :stage, foreign_key: true

      t.timestamps
    end
  end
end
