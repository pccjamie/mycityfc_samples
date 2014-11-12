# User.delete_all
Team.delete_all
User.delete_all
#seed prod with this for now...but eventually need to be able to manage all this from UI.
t1  = Team.create!(:name => 'Seattle Sounders FC', :venue => 'CenturyLink Field', :address => '6800 Occidental Ave S, Seattle, WA', :city => 'Seattle', :state => 'WA', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/seattle_150.png')
t2  = Team.create!(:name => 'New York Red Bulls', :venue => 'Red Bull Arena, Harrison, NJ', :address => '600 Cape May St, Harrison, NJ', :city => 'Harrison', :state => 'NJ', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/newyork_150.png')
t3  = Team.create!(:name => 'LA Galaxy', :venue => 'StubHub Center', :address => '18400 S Avalon Blvd, Carson, CA 90746', :city => 'Carson', :state => 'CA', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/losangeles_150.png')
t4  = Team.create!(:name => 'Colorado Rapids', :venue => 'Dick\'s Sporting Goods Park', :address => '6000 Victory Way, Commerce City, CO 80022', :city => 'Commerce City', :state => 'CO', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/colorado_150.png')
t5  = Team.create!(:name => 'Houston Dynamo', :venue => 'BBVA Compass Stadium', :address => '2200 Texas Ave, Houston, TX 77003', :city => 'Houston', :state => 'TX', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/houston_150.png')
t6  = Team.create!(:name => 'Portland Timbers', :venue => 'Jeld-Wen Field', :address => '2200 Texas Ave, Houston, TX 77003', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/portland_150.png')
t7  = Team.create!(:name => 'San Jose Earthquakes', :venue => 'Buck Shaw Stadium', :address => '500 El Camino Real, Santa Clara, CA 95050', :city => 'Santa Clara', :state => 'CA', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/sanjose_150.png')
t8  = Team.create!(:name => 'Philadelphia Union', :venue => 'PPL Park', :address => '1 Stadium Dr, Chester, PA 19013', :city => 'Chester', :state => 'PA', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/philadelphia_150.png')
t9  = Team.create!(:name => 'New England Revolution', :venue => 'Gillette Stadium', :address => '1 Patriot Pl, Foxboro, MA 02035', :city => 'Foxboro', :state => 'MA', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/newengland_150.png')
t10 = Team.create!(:name => 'Chicago Fire', :venue => 'Toyota Park', :address => '7000 S Harlem Ave, Bridgeview, IL 60455', :city => 'Bridgeview', :state => 'IL', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/chicago_150.png')
t11 = Team.create!(:name => 'Columbus Crew', :venue => 'Columbus Crew Stadium', :address => '1 Black and Gold Blvd,
Columbus, OH 43211', :city => 'Columbus', :state => 'OH', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/colombus_150.png')
t12 = Team.create!(:name => 'Toronto FC', :venue => 'BMO Field', :address => '170 Princes\' Blvd, Toronto, ON M6K 3C3, Canada', :city => 'Toronto', :state => 'ON', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/toronto_150.png')
t13 = Team.create!(:name => 'Chivas USA', :venue => 'StubHub Center', :address => '18400 S Avalon Blvd, Carson, CA 90746', :city => 'Carson', :state => 'CA', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/chivas_150.png')
t15 = Team.create!(:name => 'FC Dallas', :venue => 'FC Dallas Stadium', :address => '9200 World Cup Way, Ste 202, Frisco, TX 75034-4958', :city => 'Frisco', :state => 'TX', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/dallas_150.png')
t16 = Team.create!(:name => 'Real Salt Lake', :venue => 'Rio Tinto Stadium', :address => '9256 S State St, Sandy, UT 84070', :city => 'Sandy', :state => 'UT', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/saltlake_150.png')
t17 = Team.create!(:name => 'Vancouver Whitecaps', :venue => 'BC Place', :address => '777 Pacific Blvd, Vancouver, BC V6B 4Y8, Canada', :city => 'Vancouver', :state => 'BC', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/vancouver_150.png')
t18 = Team.create!(:name => 'Montreal Impact', :venue => 'Stade Saputo', :address => '4750 Rue Sherbrooke Est, Montreal, QC H1V 3S8', :city => 'Montreal', :state => 'QB', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/montreal_150.png')
t19 = Team.create!(:name => 'Sporting Kansas City', :venue => 'Sporting Park', :address => '1 Sporting Way, Kansas City, KS 66111', :city => 'Kansas City', :state => 'KS', :league => 'MLS', :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/sportingkclogo_150.png')
t20 = Team.create!(:name => 'New York City FC', :venue => '', :address => '',
									 :city => 'New York City', :state => 'NY', :league => 'MLS',
									 :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/nycfc_150.png')
t21 = Team.create!(:name => 'Orlando City SC', :venue => '', :address => '',
									 :city => 'Orlando', :state => 'FL', :league => 'MLS',
									 :logo => 'https://s3.amazonaws.com/soccer-production-jyr/logos/orlando_city_150.png')
