class DashboardController < ApplicationController

	require 'active_support/all'
	require 'nokogiri'
	require 'open-uri'
	require 'httparty'
	require 'chronic'

	def get_time
		@time = Time.now
		@today = @time.strftime("%A, %B %d, %Y").inspect
		@tomorrow = Chronic.parse('tomorrow')
		@yesterday = Chronic.parse('yesterday')
		[@time, @today, @tomorrow, @yesterday]
	end

	def get_video

		# some_team = current_user.primary_team.split(' ').map(&:strip) # DOES NOT WORK FOR SOMETHING LIKE FC DALLAS or CHIVAS USA
		my_saved_team = current_user.primary_team.strip

		#array of teams
		#TODO move these into env cfg file
		yt_base = 'https://www.googleapis.com/youtube/v3'
		yt_key = 'AIzaSyDRWryJz70D_ybAHQmhuiwgrHtYOuEo9tA' #ADD TO ENVCFGVAR


		yt_channels = Nokogiri::HTML(open("https://www.youtube.com/user/mls/channels")).css('.yt-lockup-title a').to_a


		yt_channels.each do |val|

			#1. Format team name
			#TODO - regex. this is brittle
			yt_team = val.text.to_s
			yt_team = yt_team.gsub('(Official)', '')
			yt_team = yt_team.strip

			# 3. Get YouTube video id for URL
			if my_saved_team == yt_team

				flash[:notice_youtube] = "Match: LOCAL NAME: #{my_saved_team} = YOUTUBE NAME: #{yt_team}"


				#2. Format YouTube user name
				#TODO regex
				yt_username = val.attributes['href'].to_s
				yt_username = yt_username.gsub('/user/', '')


				response = HTTParty.get("#{yt_base}/channels?part=id%2C+snippet&forUsername=#{yt_username}&key=#{yt_key}")

				channel_id = response["items"][0]["id"]
				channel_info = HTTParty.get("#{yt_base}/search?part=id%2C+snippet&channelId=#{channel_id}&maxResults=2&order=date&key=#{yt_key}")
				video_ids = []
				channel_info["items"].each do |item|
					video_ids.push(item["id"]["videoId"])
				end

				@video_ids = video_ids

				# respond_to do |f|
				#   f.html
				# end
			else
				#IDEAL - no match. Send empty array to view so render doesn't break
				@video_ids = []
				flash[:notice_youtube] = "Nada"

				#PATCH: provide MLS channel as backup until scraped names are properly vetted
				response = HTTParty.get("#{yt_base}/channels?part=id%2C+snippet&forUsername=mls&key=#{yt_key}")

				channel_id = response["items"][0]["id"]
				channel_info = HTTParty.get("#{yt_base}/search?part=id%2C+snippet&channelId=#{channel_id}&maxResults=2&order=date&key=#{yt_key}")
				video_ids = []
				channel_info["items"].each do |item|
					video_ids.push(item["id"]["videoId"])
				end
				@video_ids = video_ids


			end

			#
			# channel_id = response["items"][0]["id"]
			# channel_info = HTTParty.get("#{yt_base}/search?part=id%2C+snippet&channelId=#{channel_id}&maxResults=1&order=date&key=#{yt_key}")
			# video_ids = []
			# channel_info["items"].each do |item|
			#   video_ids.push(item["id"]["videoId"])
			# end
			# @video_ids = video_ids


		end

	end


	def get_schedule

		#get the users preferred team, make sure its formatted correctly for comparison to MLS schedule,
		# and based on that pull in the schedule one month back and going forward.

		#1 format name, need a regex
		my_team = current_user.primary_team.split(' ').map(&:strip)

		# CURRENT ISSUES
		#FC dallas pulls in Portsmouth FC.  Colombus breaks (sp error). Sporting KC pulls in Sporting Lisbon
		if my_team.include?("New") || my_team.include?("San") || my_team.include?("Real") || my_team.include?("LA")
			my_team = my_team[0..1].join(" ") #joins split up words into array again, for searching
			my_choice = my_team
		else
			my_choice = my_team[0]
		end
		@my_team = my_choice

		#2 send schedule to DOM for filtering
		year = Chronic.parse('this year').strftime('%Y') #allows for new year to be passed in. In US soccer, MLS season does not overlap years, so this works.
		url = "http://www.mlssoccer.com/schedule"
		doc = Nokogiri::HTML(open(url))
		menu_options_arr = doc.css('#edit-club > option').reverse.to_a

		#get only MY club's schedule
		menu_options_arr.each { |o|

			team_name = o.text
			if team_name.include? "#{my_choice}"
				@my_choice = team_name
				club_id = o['value']
				@club_id = club_id
				url2 = url+"?month=all&year=#{year}&club=#{club_id}&competition_type=all&broadcast_type=all&op=Search&form_id=mls_schedule_form"
				schedule_array = Nokogiri::HTML(open(url2)).css('.schedule-table tbody tr').to_a
				#rather than sending whole schedule to DOM, process dates here and then send in batches directly to 1. next game
				@schedule = schedule_array
			end

		}

	end


	def index

		get_time
		get_schedule
		get_video


	end


end
