$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tim/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tim"
  s.version     = Tim::VERSION
  s.authors     = ["Martyn Taylor", "Jason Guiditta"]
  s.email       = ["aeolus-devel@lists.fedorahosted.org"]
  s.homepage    = "https://github.com/aeolus-incubator/tim"
  s.license     = 'MIT'
  s.summary     = "Embeddable client for Aeolus Image Factory"
  s.description = "Rails engine client for the Aeolus Image Factory cross-cloud virtual machine image builder."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc", "tim.gemspec", "Gemfile"]
  s.test_files = Dir["{spec,test}/**/*"]
  s.test_files.reject! { |fn| fn.match(/sqlite|tmp|log/) }

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "haml"
  s.add_dependency "nokogiri"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails", "~> 4.1.0"
  s.add_development_dependency "minitest"

  #s.add_development_dependency "jquery-rails"
end
