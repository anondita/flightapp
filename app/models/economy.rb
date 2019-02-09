class Economy < ApplicationRecord
	belongs_to :flight, optional: true
	validates :seat, presence: true
	validates :row, presence: true
	validates :price, presence: true
	validates :emergency, presence: true
	validate :checkemer

	def checkemer
		if(emergency.to_i>row.to_i)
			errors.add(:emergency, "cannot be more than row")
		end
	end
end
