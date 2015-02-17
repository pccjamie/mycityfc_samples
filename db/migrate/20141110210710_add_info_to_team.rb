class AddInfoToTeam < ActiveRecord::Migration
	def change
		add_column :teams, :name, :string
		add_column :teams, :league, :string
		add_column :teams, :venue, :string
		add_column :teams, :address, :string
		add_column :teams, :city, :string
		add_column :teams, :state, :string
		add_column :teams, :logo, :text
		add_column :teams, :latitude, :float
		add_column :teams, :longitude, :float
	end
end
