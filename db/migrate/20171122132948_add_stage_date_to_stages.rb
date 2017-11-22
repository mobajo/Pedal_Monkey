class AddStageDateToStages < ActiveRecord::Migration[5.1]
  def change
  	add_column :stages, :stage_date, :date
  end
end
