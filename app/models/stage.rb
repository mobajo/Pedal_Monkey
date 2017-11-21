class Stage < ApplicationRecord
  belongs_to :trip
  has_one :start_point
  has_one :end_point




end
