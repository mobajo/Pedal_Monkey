class Stage < ApplicationRecord
  belongs_to :trip
  has_one :start_point, class_name: "Pitstop", foreign_key: "start_stage_id"
  has_one :end_point, class_name: "Pitstop", foreign_key: "end_stage_id"

default_scope { order('stage_no ASC') }

  def compute_distance
    return nil unless start_point && end_point
     options = {
      :language => :en,
      :alternative => :false,   #changed by rm from false
      :sensor => :false,
      :mode => :bicycling,
      :key => "AIzaSyCybNCrrf2cgA8kqkijg4_j6yM_ldFvpAA"
      }
    directions = GoogleDirections.new(start_point.address, end_point.address, options)
    self.distance = directions.distance.to_i / 1000
    puts self.distance
    self.save

    fail directions.status if directions.distance == 0
  end

end

