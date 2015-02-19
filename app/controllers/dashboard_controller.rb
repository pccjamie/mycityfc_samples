class DashboardController < ApplicationController

	require 'active_support/all'
	require 'nokogiri'
	require 'open-uri'
	require 'httparty'
	require 'chronic'

	def get_time
		@time      = Time.now
		@today     = @time.strftime("%A, %B %d, %Y").inspect
		@tomorrow  = Chronic.parse('tomorrow')
		@yesterday = Chronic.parse('yesterday')
		[@time, @today, @tomorrow, @yesterday]
	end


	def create_video_array(ch_username)

		if ch_username === 'mls'
			@video_ids = []
		end

		#TODO PRI 1 - move api info into env cfg file
		api_base = 'https://www.googleapis.com/youtube/v3'
		api_key  = 'AIzaSyDRWryJz70D_ybAHQmhuiwgrHtYOuEo9tA'

		videos    = HTTParty.get("#{api_base}/search?part=id%2C+snippet&channelId=#{ch_username}&maxResults=2&order=date&key=#{api_key}")
		video_ids = []
		videos["items"].each do |item|
			video_ids.push(item["id"]["videoId"])
		end

		@video_ids = video_ids

	end


	def get_video

		# some_team = current_user.primary_team.split(' ').map(&:strip) # DOES NOT WORK FOR SOMETHING LIKE FC DALLAS or CHIVAS USA
		saved_team = current_user.primary_team.strip

		# SCRAPE YOUTUBE
		domain     = "https://www.youtube.com"
		page       = "#{domain}/user/mls/channels"
		nodes      = Nokogiri::HTML(open(page))
		channels   = nodes.css('.yt-lockup-title a')
		channels   = channels.to_a

		# TODO - no longer making new array. Remove?
		#yt_channels = channel_names.map(&:text)

		# ITERATES THROUGH ARRAY AND CHECKS EACH NODE FOR PRESENCE OF SAVED TEAM NAME
		channels.each do |val|
			# puts 'CHECKING AGAINST:'
			# puts val
			ch_name = val.text

			# TODO is this gsub necessary?
			# yt_team = yt_team.gsub('(Official)', '')

			if saved_team === ch_name
				flash[:notice_youtube] = "#{saved_team} videos."

				#TODO - work on regex. this is brittle
				# FORMAT USERNAME
				ch_id                  = val.attributes['href']
				ch_id                  = ch_id.to_s
				ch_username            = ch_id.strip.gsub('/channel/', '')

				# TODO determine if any part of this older get request is still necessary
				# response = HTTParty.get("#{api_base}/channels?part=id%2C+snippet&forUsername=soundersfcdotcom&key=#{api_key}")
				# channel_id = response["items"][0]["id"]

				# CALL VIDEO ARRAY METHOD
				create_video_array(ch_username)

				respond_to do |f|
					f.html
				end

				break

			else

				flash[:notice_youtube] = "No matches found. Here are some MLS videos."
				# PROVIDE MLS CHANNEL AS USERNAME, SINCE ERB EXPECTS VALUES
				ch_username            = 'mls'
				# CALL VIDEO ARRAY METHOD
				create_video_array(ch_username)

			end

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
			my_team   = my_team[0..1].join(" ") #joins split up words into array again, for searching
			my_choice = my_team
		else
			my_choice = my_team[0]
		end
		@my_team         = my_choice

		#2 send schedule to DOM for filtering
		year             = Chronic.parse('this year').strftime('%Y') #allows for new year to be passed in. In US soccer, MLS season does not overlap years, so this works.
		url              = "http://www.mlssoccer.com/schedule"
		doc              = Nokogiri::HTML(open(url))
		menu_options_arr = doc.css('#edit-club > option').reverse.to_a

		#get only MY club's schedule
		menu_options_arr.each { |o|

			team_name = o.text
			if team_name.include? "#{my_choice}"
				@my_choice     = team_name
				club_id        = o['value']
				@club_id       = club_id
				url2           = url+"?month=all&year=#{year}&club=#{club_id}&competition_type=all&broadcast_type=all&op=Search&form_id=mls_schedule_form"
				schedule_array = Nokogiri::HTML(open(url2)).css('.schedule-table tbody tr').to_a
				#rather than sending whole schedule to DOM, process dates here and then send in batches directly to 1. next game
				@schedule      = schedule_array
			end

		}

	end


	def index

		get_time
		get_schedule
		get_video

	end


end