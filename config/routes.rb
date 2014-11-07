Rails.application.routes.draw do

	# AUTO GENERATED WITH CONTROLLER / VIEW
	get 'dashboard/index'


	# generating User model via Devise adds this default route
	# devise_for :users

=begin

1.Installing gem omniauth-facebook and enabling omniauthable in User model provided two new paths

	user_omniauth_authorize_path(provider)
	user_omniauth_callback_path(provider)

2.Use first path in view. Clicking sends user to FB to see permissions and approve.
	<%= link_to "Sign in with Facebook", user_omniauth_authorize_path(:facebook) %>

3.Approval redirects user to the related callback method defined in
	User::OmniauthCallbacksController

=end

	# SO we need to change devise_for :users by specifying which controller should NOW be used instead of the default controller for handling the callback process (since that is where we defined the facebook method)



	devise_for :users,
						 :controllers => {
							 :omniauth_callbacks => "users/omniauth_callbacks" # User::OmniauthCallbacksController
						 },
						 :path_names => {
							 	sign_in: 'devise/sessions#new', #:as => :new_user_session,
								sign_out: 'devise/sessions#destroy' #:as => :destroy_user_session
						 }

	# Route sign out to Devise default session ctrl destroy method

	# devise_scope :user do
	# 	# if ONLY using omniauth, add a sign_in route (or use root)
	# 	get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
	# 	# required
	# 	get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
	# end



	# ROOT
	#no auth
	root 'static_pages#landing'

	#with auth
	#pending

end
