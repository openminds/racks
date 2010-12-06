module ServerRacksHelper
	def show_info_for_server_rack(server_rack)
		comment =  content_tag :p, server_rack.comment
		concat(comment)
		available_units = content_tag :p, "Available units: #{server_rack.units.available.size}/#{server_rack.units.size}"
		concat(available_units)
		if server_rack.units.available.any?
			biggest = content_tag :p, "Biggest space: #{server_rack.biggest_available_space.size}U (#{server_rack.biggest_available_space.first.number} - #{server_rack.biggest_available_space.last.number})"
			concat(biggest)
		end
	end
end
