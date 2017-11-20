class Accommodation < ApplicationRecord
  belongs_to :stage

  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true 
  validates :longitude, presence: true
  validates :price, presence: true
end
