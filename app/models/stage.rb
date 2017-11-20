class Stage < ApplicationRecord
  belongs_to :trip

  validates :startpoint_address, presence: true
  validates :endpoint_address, presence: true


end
