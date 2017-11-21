class CreateStages < ActiveRecord::Migration[5.1]
  def change
    create_table :stages do |t|
      t.integer :stage_no
      t.integer :distance
      t.integer :elevation
      t.date    :stage_date
      t.references :trip, foreign_key: true
      t.timestamps
    end
  end
end
