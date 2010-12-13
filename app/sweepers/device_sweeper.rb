class DeviceSweeper < ActionController::Caching::Sweeper
	observe Device

	def after_save(device)
		expire_cache(device)
	end
	
	def after_create(device)
		expire_cache(device)
	end

	def after_destroy(device)
		expire_cache(device)
	end

	private

	def expire_cache(device)
		expire_fragment dom_id(current_server_rack)
		expire_fragment "drawing_#{dom_id(current_server_rack)}"
		expire_fragment dom_id(device)
		device.interfaces.each do |interface|
			if interface.other
				expire_fragment dom_id(interface.other.device)
			end
		end
	end

end