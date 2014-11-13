Rails.application.routes.draw do

	get 'dashboard/index'
	get 'teams/index'

=begin
- Desc:
	Installing gem omniauth-facebook and enabling omniauthable in User model provided two new paths

	- user_omniauth_authorize_path(provider)
	- user_omniauth_callback_path(provider)

- Usage:
	<%= link_to "Sign in with Facebook", user_omniauth_authorize_path(:facebook) %>

- Result:
	Redirects user to :facebook, defined in User::OmniauthCallbacksController (inherits from Devise default)
=end


	devise_for :users,
						 :controllers => {
							 :omniauth_callbacks => 'users/omniauth_callbacks',
							 :registrations => 'users/registrations',
							 :sessions => 'users/sessions'
						 },
						 :path_names  => {
							 sign_in:  'devise/sessions#new', #:as => :new_user_session,
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

	root 'static_pages#landing'

	authenticated do
		root :to => 'dashboard#index', :as => :authenticated
	end

end
