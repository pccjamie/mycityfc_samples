class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.

	# before_filter :set_cache_buster
	#
	# def set_cache_buster
	# 	response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
	# 	response.headers["Pragma"] = "no-cache"
	# 	response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
	# end

	protect_from_forgery with: :exception

	before_action :authenticate_user!, :except => [:landing], :unless => :user_signed_in?

	add_flash_types :notice_vendor, :notice_twitter, :notice_youtube, :notice_geo, :notice_content_pending, :notice_local

# Devise helpers
	def after_sign_in_path_for(user)
		#must save distance in order for redirect path to load the LOCAL TEAMS content corrctly.
		if user.primary_team.nil?
			teams_index_path
		else
			dashboard_index_path
		end
	end

	def after_sign_out_path_for(user)
		root_path
	end


	# sign_in route helper
	def new_session_path(user) # defines new path if only using omniauth
		new_user_session_path
	end

end
