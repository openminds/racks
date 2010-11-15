desc 'Set colors for connections that werent filled in to Gray'
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
desc 'Try to set the devicetype from comments or name'
namespace :db do
	namespace :cleanup do
		task :add_device_types => [:environment] do
			server_counter = 0
			router_counter = 0
			switch_counter = 0
			power_bar_counter = 0
			
			Device.where('device_type IS NULL').each do |device|
				if device.name.downcase.include?("server") || device.comment.downcase.include?("server")
					device.device_type = 1;
					device.save!
					server_counter +=1
				end
				if device.name.downcase.include?("router") || device.comment.downcase.include?("router")
					device.device_type = 2;
					device.save!
					router_counter +=1
				end
				if device.name.downcase.include?("switch") || device.comment.downcase.include?("switch")
					device.device_type = 3;
					device.save!
					switch_counter +=1
				end
				if device.name.downcase.include?("powerbar") || device.comment.downcase.include?("powerbar")
					device.device_type = 4;
					device.save!
					power_bar_counter +=1
				end
			end
			puts "Updated #{server_counter} servers"
			puts "Updated #{router_counter} routers"
			puts "Updated #{switch_counter} switches"
			puts "Updated #{power_bar_counter} powerbars"
		end
	end
end
