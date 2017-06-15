$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_running_version/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_running_version"
  s.version     = RailsRunningVersion::VERSION
  s.authors     = ["John"]
  s.email       = ["john@burnabycoding.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "README.md"]

  s.add_dependency "rails", "> 3.2"
end
