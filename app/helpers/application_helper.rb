module ApplicationHelper
	def timeformat(time)
   		time.strftime("%I:%M%P")
 	end
 	def dateformat(date)
  		date.strftime("%b %d")
 	end
end
