class ServerRackReport < Prawn::Document

	def to_pdf(server_rack)
		#font settings
		self.font_size = 12
		font("Helvetica")
		indent = 15
		#Title
		font("Helvetica", :style => :bold, :size => 18) do
			text "#{server_rack.name} in #{server_rack.datacenter.name}"
		end
		# Rack information:
		text server_rack.comment
		text "Units: #{server_rack.units.available.size} / #{server_rack.units.size}"
		text "Biggest available space: #{server_rack.biggest_available_space.size} (#{server_rack.biggest_available_space.first.number} - #{server_rack.biggest_available_space.last.number})"
		text "Lock: #{server_rack.lock_code}"

		# Devices
		server_rack.devices.each do |device|
			move_down 20
			font("Helvetica", :style => :bold, :size => 16) do
				device_title = "#{device.units.first.number}"
				if device.units.size > 1
					device_title += " - #{device.units.last.number}"
				end
				device_title += ": #{device.device_type(:name)}: #{device.name}"
				text device_title
			end

			text "#{device.comment}", :indent_paragraphs => indent
			text " Used by: #{device.company_names}", :indent_paragraphs => indent

			font("Helvetica", :style => :bold, :size => 14) do
				text "Interfaces", :indent_paragraphs => indent
			end
			#interfaces
			interfaces = []
			device.interfaces.each do |interface|
				arr = []
				arr[0] = interface.name
				if interface.other
					arr[1] = "(#{interface.cable_connection.color}) connected to"
					arr[2] = "#{interface.other.to_s}"
				else
					arr[1] = " "
					arr[2] = " "
				end
				interfaces << arr
			end
			table(interfaces, :width => 400)
		end
	
		# Render it!
		render
	end
end