class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable

	geocoded_by :city
	after_validation :geocode

	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable,
				 :omniauth_providers => [:facebook]

	def self.add_info_from_omniauth(auth) #called by User::OmniauthCallbacksController

		# find existing or create new

		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

			# SCHEMA - https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema

			user.email      = auth.info.email
			user.name       = auth.info.name

			#TODO - migrate url field to db. then add to User model omniauth hash. Will be used to provide user direct link back to
			# FB profile
			# if they need  to update something.

			# user.url = auth.extra.raw_info.link

			user.first_name = auth.info.first_name
			user.picture    = auth.info.image

			# TEMP - compensates for user not having set a current location in their FB profile
			# TODO - find a more robust solution
			if auth.info.location == nil
				user.location = 'Seattle, Washington'
				user.city     = user.location.split(',').first
				user.state    = user.location.split(',').last.strip
			else
				user.location = auth.info.location
				user.city     = auth.info[:location].split(',').first
				user.state    = auth.info[:location].split(',').last.strip
			end

			user.password = Devise.friendly_token[0, 20]

			# u.name = auth.extra.raw_info.name
			# u.provider = auth.provider
			# u.uid = auth.uid

		end

		# see https://github.com/mkdynamic/omniauth-facebook

	end

end
