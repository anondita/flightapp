class Booking < ApplicationRecord
  before_create :generate
  before_destroy :restore_availability
  before_create :check_availability

  belongs_to :user
  belongs_to :flight
  has_many :seatofbookings,dependent: :destroy
  validates :seats, presence: true
  validates :seatclass, presence: true
  class << self
  	def new_token
  		SecureRandom.hex(4)
  	end
  end

  	def check_availability
  		if (self.seatclass === 'first')
        att = self.flight.firstclass.availability - self.seats
  				if(att>=0 )
            puts self.seats
  					
            puts att
  					self.flight.firstclass.update_column(:availability,att)
  				else
  					errors.add(:firstclass_id,'unavailable number of seats')
  				end
  		elsif (self.seatclass === 'business')
        att = self.flight.business.availability - self.seats
  				if(att>=0 )
  					self.flight.business.update_column(:availability,att)
  				else
  					errors.add(:business_id,'unavailable number of seats')
  				end
  		elsif (self.seatclass === 'economy')
         att = self.flight.economy.availability - self.seats
  				if(att>=0)
  					self.flight.economy.update_column(:availability,att)
  				else
  					errors.add(:economy_id,'unavailable number of seats')
  				end
  		end
  	end

  	def restore_availability
    		if (self.seatclass === 'first')
    			att = self.flight.firstclass.availability + self.seats
    			self.flight.firstclass.update_column(:availability,att)
    		elsif (self.seatclass === 'business')
    			att = self.flight.business.availability + self.seats
    			self.flight.business.update_column(:availability,att)
    		elsif (self.seatclass === 'economy')
    			 att = self.flight.economy.availability + self.seats
    			self.flight.economy.update_column(:availability,att)
    		end
        seats = Seat.where(:booking_id => self.id)
        seats.each do |s|
          s.update_attributes(booking_id: nil,available: true, pnr: nil)
        end
     	end

  private
  	def generate
  		self.pnr = Booking.new_token
  	end
end
