$:.push File.expand_path("../lib", __FILE__)
require "acts_as_rateable/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_rateable"
  s.version     = ActsAsRateable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John 'asceth' Long"]
  s.email       = ["machinist@asceth.com"]
  s.homepage    = "http://github.com/asceth/acts_as_rateable"
  s.summary     = "Ratings for Rails"
  s.description = "A gem for handling rating in Rails"

  s.rubyforge_project = "acts_as_rateable-asceth"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rr'
end
