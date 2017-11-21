class Stage < ApplicationRecord
  belongs_to :trip

  validates :startpoint_address, presence: true
  validates :endpoint_address, presence: true

  geocoded_by :startpoint_address
  after_validation :geocode, if: :startpoint_address_changed?

end
