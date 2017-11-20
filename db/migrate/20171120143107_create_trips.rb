class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :title
      t.integer :distance
      t.integer :elelevation

      t.timestamps
    end
  end
end
