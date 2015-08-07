$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hot_drinks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hot_drinks"
  s.version     = HotDrinks::VERSION
  s.authors     = ["amcaplan"]
  s.email       = ["ariel.caplan@vitals.com"]
  s.homepage    = "http://github.com/amcaplan/hot_drinks"
  s.summary     = "Hot Drinks allows your application to serve up tea and coffee."
  s.description = "Hot Drinks allows your application to serve up tea and coffee."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "rspec-rails", "~> 3.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.5"

  s.add_development_dependency "sqlite3"
end
