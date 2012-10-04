# FIXME Remove filter once support for custom XML with nested resources is
# supported.
module Tim
  class UserKeysFilter

    @@user_keys = { "base_image"        => "base_image_attributes",
                  "image_versions"    => "image_versions_attributes",
                  "image_version"     => "image_version_attributes",
                  "target_images"     => "target_image_attributes",
                  "target_image"      => "target_image_attributes",
                  "provider_images"   => "provider_images_attributes",
                  "provider_image"    => "provider_image_attributes",
                  "template"          => "template_attributes" }

    def self.before(controller)
      begin
        resource_name = controller.controller_name.singularize.to_sym
        controller.params[resource_name] = replace_user_keys(controller.params[resource_name])
      rescue => e
        controller.head :unprocessable_entity
      end
    end

    # Replaces all instances of user keys with those defined in @@user_keys
    # Supports N levels of nested maps.
    def self.replace_user_keys(map)
      modified_map = map.clone
      map.each_pair do |key, value|
        if @@user_keys.has_key? key
          if map[key].instance_of? Hash
            # FIXME Using recursion in this way increases heap memory usage.
            # If we decide to stick with this approach a more memory efficient
            # implementation should be considered.
            modified_map[key] = replace_user_keys(map[key])
          end
          modified_map[@@user_keys[key]] = modified_map.delete(key)
        end
      end
      modified_map
    end
  end
end