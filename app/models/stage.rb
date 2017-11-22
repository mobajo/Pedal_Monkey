class Stage < ApplicationRecord
  belongs_to :trip
  has_one :start_point, class_name: "pitstop", foreign_key: "start_stage_id"
  has_one :end_point, class_name: "pitstop", foreign_key: "start_stage_id"



end
