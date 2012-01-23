module ActsAsRateable
  class Engine < Rails::Engine
    initializer 'acts_as_rateable.ar_extensions', :before => "action_controller.deprecated_routes" do |app|
      ::ActiveRecord::Base.send(:include, ActsAsRateable::Extend)
    end
  end
end
