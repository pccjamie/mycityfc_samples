# class Users::SessionsController < Devise::SessionsController
#
# 	# inherits from and adds to Devise::RegistrationsController
# 	# here, just tweaking two private methods that handle parameter sanitization before updating the User model.
#
#
# 	def sign_in
#
# 	end
#
# 	private
#
# 	def sign_in_params
# 		params.require(:user).permit!
# 	end
#
# end