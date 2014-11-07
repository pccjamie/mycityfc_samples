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

			# pulling in min info for now
					user.email = auth.info.email
					user.password = Devise.friendly_token[0,20]
					user.name = auth.info.name
					user.first_name = auth.info[:first_name]
					user.location = auth.info[:location]
					user.location = auth.info.location

					user.picture = auth.info.image

			# u.name = auth.extra.raw_info.name
			# u.first_name = auth.info[:first_name]
			# u.provider = auth.provider
			# u.uid = auth.uid
			# u.email = auth.info.email
			# u.password = Devise.friendly_token[0, 20]
			# u.location = auth.info[:location]
			# u.city = auth.info[:location].split(',').first
			# u.state = auth.info[:location].split(',').last
			# u.picture = auth.info[:image]


		end

		# see https://github.com/mkdynamic/omniauth-facebook

	end

end
