class Users::RegistrationsController < Devise::RegistrationsController

	before_filter :authenticate_user!


	# override Devise's registrations#update
	def update
		old_team = current_user.primary_team

		#account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

		# bypass Devise default PW requirements
		if params[:user][:password].blank?
			params[:user].delete("password")
			params[:user].delete("password_confirmation")
		end


		# update acct
		@user = User.find(current_user.id)
		if @user.update_attributes(account_update_params)
			set_flash_message :notice, :updated
			# Sign in the user bypassing validation in case their password changed
			sign_in @user, :bypass => true

			if @user.primary_team != old_team
				flash[:notice] = "#{@user.primary_team}"
				redirect_to dashboard_index_path
			else
				flash[:notice] = 'No change, just updated something esle'
				redirect_to teams_index_path
			end

		else
			render "edit"
		end

	end


	private

	# App allows user to update their profile (see User model) after sign up/sign in. These overrides of default Devise methods specify the params which should be sanitized so that accounts can be created, edited, and saved correctly. Careful, ONLY specify what the user should be able to edit directly from within the website.

	# TODO -  specify exact params to sanitize instead of permitting entire hash

	def sign_up_params
		params.require(:user).permit!
	end

	def account_update_params
		params.require(:user).permit!
	end


end