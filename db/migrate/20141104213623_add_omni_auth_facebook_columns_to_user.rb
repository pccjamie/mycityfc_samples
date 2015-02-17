class AddOmniAuthFacebookColumnsToUser < ActiveRecord::Migration
	def change
		add_column :users, :name, :string
		add_column :users, :first_name, :string
		add_column :users, :location, :string
		add_column :users, :city, :string
		add_column :users, :state, :string
		add_column :users, :picture, :string
		add_column :users, :primary_team, :string
	end
end
