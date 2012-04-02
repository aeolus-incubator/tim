# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "image_management"
  s.summary = "Insert ImageManagement summary."
  s.authors     = ["Red Hat Inc."]
  s.description = "Insert ImageManagement description."
  s.files = Dir["{app,lib,config}/**/*"] + ["Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
end
