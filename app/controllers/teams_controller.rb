class TeamsController < ApplicationController

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

		# teams.map { |t|
		# 	if t.league == 'NASL'
		# 		@nasl = []
		# 		@nasl.push(t)
		# 	end
		# }
		#
		# teams.map { |t|
		# 	if t.league == 'MLS'
		# 		@mls =[]
		# 		@mls.push(t)
		# 	end
		# }
		#
		# 	if @teams.blank?
		# 	flash[:notice_content_pending]='Content pending'
		# end

	end

	def show

		@team = Team.find(params[:id])

	end

end
