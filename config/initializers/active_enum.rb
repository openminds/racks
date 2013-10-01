# Form helper integration
# require 'active_enum/form_helpers/simple_form'
# require 'active_enum/form_helpers/formtastic

ActiveEnum.setup do |config|

  # Extend classes to add enumerate method
  config.extend_classes = [ ActiveRecord::Base ]

  # Return name string as value for attribute method
  # config.use_name_as_value = false

  # Storage of values
  # config.storage = :memory

end

ActiveEnum.define do

  enum(:device_type) do
       value :id => 1, :name => 'Server'
    value :id => 2, :name => 'Router'
    value :id => 3, :name => 'Switch'
    value :id => 4, :name => 'Powerbar'
    value :id => 5, :name => 'Firewall'
    value :id => 6, :name => 'STS'
    value :id => 7, :name => 'Rented out'
  end

end
