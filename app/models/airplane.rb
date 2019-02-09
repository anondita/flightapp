class Airplane < ApplicationRecord
	has_many :flights
	before_destroy :flightdestroy
	validates :name,  presence: true
	validates :typeofplane,  presence: true
	validates :firstrow, presence: true
	validates :firstseat, presence: true
	validates :firstemer,  presence: true
	validates :firstprice,  presence: true
	validates :ecorow, presence: true
	validates :ecoseat, presence: true
	validates :ecoemer,  presence: true
	validates :ecoprice,  presence: true
	validates :busrow, presence: true
	validates :busseat, presence: true
	validates :busemer,  presence: true
	validates :busprice,  presence: true
	validate :checkemer

	def checkemer
		if(firstemer.to_i>firstrow.to_i)
			errors.add(:firstemer, "cannot be more than first row")
		end
		if(ecoemer.to_i>ecorow.to_i)
			errors.add(:ecoemer, "cannot be more than economy row")
		end
		if(busemer.to_i>busrow.to_i)
			errors.add(:busemer, "cannot be more than business row")
		end
	end

	def flightdestroy
		Flight.where(airplane_id: self.id).destroy_all
	end
end
