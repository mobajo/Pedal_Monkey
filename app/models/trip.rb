class Trip < ApplicationRecord
	has_many :trip_members, dependent: :destroy
	has_many :stages, dependent: :destroy

  def find_stage(num)
    self.stages.find { |stage| stage.stage_no == num }
  end

  def set_stages(stage_no, start_date, end_date)

    days = (end_date.to_date - start_date.to_date).to_i + 1
    stage_date = start_date.to_date

    days.times do |day_number|
      stages.new(
        stage_no: stage_no + day_number,
        stage_date: stage_date + day_number
        )
    end

  end

  def update_distance
    self.distance = self.stages.map(&:distance).reduce(:+)
    self.save
  end

end
