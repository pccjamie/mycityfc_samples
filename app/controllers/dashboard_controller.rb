class DashboardController < ApplicationController

	#user can nav directly to dashboard URL. Prevent this by requiring
	#before_action :authenticate_user!

	def after_update_path_for(user)
			dashboard_index_path
	end

end
