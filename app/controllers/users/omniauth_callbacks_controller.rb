# Adds provider-specific callback handling.
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def foo
		render :text => 'hello. i am foo.'
	end

	def facebook
		# render :text => "<pre>" + request.env["omniauth.auth"].to_yaml and return

		@user = User.add_info_from_omniauth(request.env["omniauth.auth"])

		# User model validates save. If validation failed, we wouldn't know.
		# So we check persistence first.
		if @user.persisted?
			sign_in_and_redirect @user,
													 :event => :authentication
			# throws if @user is not activated. Otherwise, sends user to after_sign_in_path (ApplicationController) which should eventually be dashboard_index_path

			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format? #TODO is this needed?

		else
			# Clears current session
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			# sends user back to reg path
			redirect_to new_user_registration_url # loads default Devise view for now from gem
			#TODO replace this with root_path when view is coded
		end

	end

	# DEVISES BASIC OMNIAUTH SETUP - https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

end