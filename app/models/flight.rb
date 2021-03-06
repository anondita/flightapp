class Flight < ApplicationRecord
	belongs_to :airplane, optional: true
	has_one :economy
	has_one :firstclass
	has_one :business
	has_many :bookings
	has_many :seats, dependent: :destroy
	before_destroy :destroybooking
	validates :name,  presence: true
	validates :source,  presence: true
	validates :destination, presence: true
	validates :dateofflight, presence: true
	validate :date_cannot_be_in_the_past
    validate :end_must_be_after_start
    validate :source_dest
    before_save :capitalizestring

    def source_dest
    	if(source.downcase === destination.downcase)
    		errors.add(:destination, "cannot be same as source")
    	end
    end

    def capitalizestring
    	self.source = source.capitalize
    	self.destination = destination.capitalize
    end

    def end_must_be_after_start
	  if arrive <= depart
	    errors.add(:arrive, "cannot be before departure")
	  end
    end

	def date_cannot_be_in_the_past
	   if (dateofflight.present? && dateofflight.past?)
	      errors.add(:dateofflight, "can't be in the past")
	    end
	 end 

	def destroybooking
		if(self.bookings.exists?)
		self.bookings.destroy_all
		end
		if(!self.firstclass.nil?)
		self.firstclass.destroy
		end
		if(!self.business.nil?)
		self.business.destroy
		end
		if(!self.economy.nil?)
		self.economy.destroy
	end
	end
end
