module ActsAsRateable
  class Railtie < Rails::Railtie
    initializer "acts_as_rateable.initialize" do |app|
      ::ActiveRecord::Base.send(:include, ActiveRecord::Acts::Rateable)
    end
  end
end
