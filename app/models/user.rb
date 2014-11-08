class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable

	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable,
				 :omniauth_providers => [:facebook]

	def self.add_info_from_omniauth(auth) #called by User::OmniauthCallbacksController

		# find existing or create new
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

			#	none found so create a new one based on hash of FB info.
			# SCHEMA - https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema

					user.email = auth.info.email
					user.name = auth.info.name
					user.first_name = auth.info.first_name
					user.location = auth.info.location
					user.picture = auth.info.image
					user.city = auth.info[:location].split(',').first
					user.state = auth.info[:location].split(',').last.strip
					user.password = Devise.friendly_token[0,20]

			# u.name = auth.extra.raw_info.name
			# u.provider = auth.provider
			# u.uid = auth.uid


		end

		# see https://github.com/mkdynamic/omniauth-facebook

	end

end
