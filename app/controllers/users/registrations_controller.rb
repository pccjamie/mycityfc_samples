class Users::RegistrationsController < Devise::RegistrationsController

	# inherits from and adds to Devise::RegistrationsController
	# here, just tweaking two private methods that handle parameter sanitization before updating the User model.

	private

	# TODO - turn this on once I add db authentication. Right now, only using Omniauth-facebook, which does not allow signing up and specifying your own params during the acct creation process.


	def sign_up_params
		params.require(:user).permit!
	end


	# App allows user to update their profile (User model attrs) after sign in. This specifies params which should be sanitized so that they can be saved to in the User model.

	def account_update_params
		params.require(:user).permit!
	end
end