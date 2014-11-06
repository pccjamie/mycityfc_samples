class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception


	# Devise helpers

	def after_sign_in_path_for(user)
		root_path
	end


	# sign_in route helper
	def new_session_path(user) # defines new path if only using omniauth
		new_user_session_path
	end


end
