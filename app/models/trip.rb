class Trip < ApplicationRecord
	has_many :trip_members
	has_many :stages, dependent: :destroy

   	validates :title, presence: true

end
