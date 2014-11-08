class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

	#todo add handler for cross browser requests

  protect_from_forgery with: :exception
	# before_action :configure_permitted_parameters, if: :devise_controller?

	# Devise helpers
	def after_sign_in_path_for(user)
		if (user.primary_team || user.distance).nil?
			edit_user_registration_path
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

	# protected
	#
	# def configure_permitted_parameters
	# 	devise_parameter_sanitizer.for(:sign_in) << :location
	# 	devise_parameter_sanitizer.for(:sign_up) << :location
	# 	devise_parameter_sanitizer.for(:account_update) << :location
	# end


end
