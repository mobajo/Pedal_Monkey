class TripMember < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  # validates :user, uniqueness: true, presence: true
  # validates :trip, uniqueness: true, presence: true
  validates_uniqueness_of :trip_id, :scope => :user_id
end
