class Trip < ApplicationRecord
	has_many :trip_members
	has_many :stages, dependent: :destroy

  def find_stage(num)
    self.stages.find { |stage| stage.stage_no == num }
  end
end
