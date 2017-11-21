class Accommodation < ApplicationRecord
  belongs_to :stage

  validates :name, presence: true
end
