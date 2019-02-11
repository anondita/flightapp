class ApplicationController < ActionController::Base

	def admin_check
		if (current_user.admin?)
		else
			redirect_to root_path
		end
	end
end
