class TeamsController < ApplicationController


	def after_update_path_for(user)
		teams_index_path
	end

	#method
	def get_local_teams

		travel_distance  = current_user.distance
		@local_teams     = Team.near([current_user.latitude, current_user.longitude], travel_distance)
		@travel_distance = travel_distance
		#
		# if travel_distance < 30
		# 	flash[:notice_geo] = 'Hmmm...looks like you might need to search a little farther.'
		# else
		# 	flash[:notice_geo] = 'Working.'
		# end

		# if current_user.distance_changed?
		#   @nearby_teams = Team.near([current_user.latitude, current_user.longitude], current_user.distance)
		#   #redirect_to main_index_path
		# end
		#
		# @nearby_teams = Team.near([current_user.latitude, current_user.longitude], current_user.distance)

	end

	#render view
	def index

		#return local teams
		get_local_teams

		#return all teams
		teams  = Team.all
		@teams = teams.sort_by { |t| t[:name] }


		def show

			@team = Team.find(params[:id])

		end

	end


end
