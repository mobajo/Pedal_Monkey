class Pitstop < ApplicationRecord
  belongs_to :start_stage, class_name: "Stage", foreign_key: "start_stage_id", optional: :final_stop?
  belongs_to :end_stage, class_name: "Stage", foreign_key: "end_stage_id", optional: :first_stop?

  validates :name, presence: true

  def final_stop?
    self.end_stage.trip.stages.count == self.end_stage.stage_no
  end

  def first_stop?
    self.start_stage.stage_no == 1
  end
end
