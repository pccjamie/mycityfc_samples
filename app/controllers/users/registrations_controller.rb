class Users::RegistrationsController < Devise::RegistrationsController

	private

	# App allows user to update their profile (see User model) after sign up/sign in. These overrides of default Devise methods specify the params which should be sanitized so that accounts can be created, edited, and saved correctly. Careful, ONLY specify what the user should be able to edit directly from within the website.

	# TODO -  specify attrs instead of using global permit
	def sign_up_params
		params.require(:user).permit!
	end

	# TODO -  specify attrs instead of using global permit
	def account_update_params
		params.require(:user).permit!
	end


end