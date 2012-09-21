$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "image_management/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "image_management"
  s.version     = ImageManagement::VERSION
  s.authors     = ["Martyn Taylor", "Jason Guiditta"]
  s.email       = ["aeolus-devel@lists.fedorahosted.org"]
  s.homepage    = "https://github.com/aeolus-incubator/image-management-engine"
  s.summary     = "Embeddable client for Aeolus Image Factory"
  s.description = "Rails engine client for the Aeolus Image Factory cross-cloud virtual machine image builder."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["{spec,test}/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "haml"
  s.add_dependency "nokogiri"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
end
