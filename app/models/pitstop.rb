class Pitstop < ApplicationRecord
  belongs_to :start_stage, class_name: "Stage", foreign_key: "start_stage_id"
  belongs_to :end_stage, class_name: "Stage", foreign_key: "end_stage_id"

  validates :name, presence: true
end
