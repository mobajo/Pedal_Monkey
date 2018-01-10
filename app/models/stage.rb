class Stage < ApplicationRecord
  belongs_to :trip
  has_one :start_point, class_name: "Pitstop", foreign_key: "start_stage_id", dependent: :destroy
  has_one :end_point, class_name: "Pitstop", foreign_key: "end_stage_id", dependent: :destroy

default_scope { order("stage_no ASC") }

  def compute_distance
    return nil unless start_point && end_point
# start_point.address changed to lat/lng to allow unnamed roads
    gmaps = GoogleMapsService::Client.new(key: ENV['GOOGLE_API_BROWSER_KEY'])
    routes = gmaps.directions((origin=start_point.latitude,start_point.longitude), (destination=end_point.latitude,end_point.longitude),
    mode: "bicycling",
    alternatives: false,
    avoid: "highways",
    avoid: "ferries"
    )

    distance_in_m = routes[0][:legs][0][:distance][:value]
    self.distance = distance_in_m / 1000.to_f
    puts self.distance
    self.save


  end

end

