ACTS_AS_RATEABLE_PATH = File.dirname(__FILE__) + "/acts_as_rateable"
require "#{ACTS_AS_RATEABLE_PATH}/extend"
require "#{ACTS_AS_RATEABLE_PATH}/version"
require "#{ACTS_AS_RATEABLE_PATH}/engine" if defined?(Rails)

module ActsAsRateable
end

