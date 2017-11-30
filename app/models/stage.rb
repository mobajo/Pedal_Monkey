class Stage < ApplicationRecord
  belongs_to :trip
  has_one :start_point, class_name: "Pitstop", foreign_key: "start_stage_id", dependent: :destroy
  has_one :end_point, class_name: "Pitstop", foreign_key: "end_stage_id", dependent: :destroy

default_scope { order('stage_no ASC') }

  def compute_distance
    return nil unless start_point && end_point

    gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_BROWSER_KEY'])
    routes = gmaps.directions(start_point.address, end_point.address,
    mode: 'bicycling',
    alternatives: false)

    distance_in_m = routes[0][:legs][0][:distance][:value]
    self.distance = distance_in_m / 1000
    puts self.distance
    self.save

#    fail directions.status if directions.distance == 0
  end

end

