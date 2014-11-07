class DashboardController < ApplicationController

	#user can nav directly to dashboard URL. Prevent this by requiring
	before_action :authenticate_user!

end
