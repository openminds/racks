namespace :db do
	namespace :cleanup do
		task :add_missing_colors => [:environment] do
			counter = 0
			CableConnection.where('color LIKE "" OR color IS NULL').each do |cable_connection|
				cable_connection.color = "Gray"
				cable_connection.save!
				counter += 1
			end
			puts	"Updated #{counter} connections"
		end
	end
end
