require "image_management/engine"
require "image_factory/image_factory.rb"
require "rails_patches/active_record/base.rb"

# Active Resource Patches for 3.0.10.  These can be removed once we upgrade to
# Rails 3.2.3
require "rails_patches/active_resource/base.rb"
require "rails_patches/active_resource/formats.rb"
