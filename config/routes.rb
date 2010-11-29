Racks::Application.routes.draw do
	get "admin/index"
	match "admin/no_rights"
	match 'admin/grant_user_rights/:user_id' => 'admin#grant_user_rights', :as => :grant_user_rights
	match 'admin/grant_admin_rights/:user_id' => 'admin#grant_admin_rights', :as => :grant_admin_rights
	match 'admin/delete_user/:user_id' => 'admin#delete_user', :as => :delete_user

	devise_for :users

	get "search/search", :as => 'search'
	get "search/ajax_search"
	get "search/find_colors"
	get "search/company_names"
	get "devices/collect_interfaces"
	
	post "api/get_devices_for_customer/:customer_number" => "api#get_devices_for_customer", :defaults => { :format => 'xml' }
	#resources :cable_connections

	#resources :interfaces

	resources :companies

	resources :datacenters, :except => [:show] do
		resources :server_racks do
			resources :devices, :except => [:index] do
				resources :interfaces, :except => [:index, :show]
			end
		end
	end

	# The priority is based upon order of creation:
	# first created -> highest priority.

	# Sample of regular route:
	#   match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action

	# Sample of named route:
	#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)

	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Sample resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Sample resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Sample resource route with more complex sub-resources
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', :on => :collection
	#     end
	#   end

	# Sample resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	root :to => "datacenters#index"

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
