class Users::SessionsController < Devise::SessionsController

	private

	# TODO -  specify attrs instead of using global permit
	def sign_up_params
		params.require(:user).permit!
	end

end