class Stage < ApplicationRecord
  belongs_to :trip
  has_one :start_point, class_name: "Pitstop", foreign_key: "start_stage_id"
  has_one :end_point, class_name: "Pitstop", foreign_key: "end_stage_id"
end


#class Stage < ApplicationRecord
#  belongs_to :trip
#  has_one :start_point, class_name: "Pitstop", foreign_key: "start_stage_id"
#  has_one :end_point, class_name: "Pitstop", foreign_key: "start_stage_id"



#end
