class Trip < ApplicationRecord
	has_many :trip_members
	has_many :stages, dependent: :destroy

  def find_stage(num)
    self.stages.find { |stage| stage.stage_no == num }
  end

  def set_stages(stage_no, start_date, end_date)
    first_stage = stages.new(stage_no: 1, stage_date: start_date)
    
    days = (end_date.to_date - start_date.to_date).to_i
    stage_date = start_date.to_date
    
    days.times do
      stage = stages.new
      stage_no += 1
      stage.stage_no = stage_no
      stage_date += 1
      stage.stage_date = stage_date
    end
  end

end