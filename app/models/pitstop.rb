class Pitstop < ApplicationRecord
  belongs_to :start_stage, class_name: "Stage", foreign_key: "start_stage_id", optional: :final_stop?
  belongs_to :end_stage, class_name: "Stage", foreign_key: "end_stage_id", optional: :first_stop?

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def final_stop?
    self.end_stage ? self.end_stage.trip.stages.count == self.end_stage.stage_no : false
  end

  def first_stop?
    self.start_stage&.stage_no == 1
  end
end