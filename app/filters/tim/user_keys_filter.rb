# FIXME Remove replace_user_keys(map) once support for custom XML with nested
# resources is supported.

module Tim
  class UserKeysFilter

    @@user_keys = YAML.load(File.read(File.join(Tim::Engine.root, "config", "user_keys.yml")))

    def self.before(controller)
      begin
        @controller = controller
        resource_name = @controller.controller_name.singularize.to_sym
        set_template_params(resource_name)
        @controller.params[resource_name] = replace_user_keys(@controller.params[resource_name], @@user_keys[resource_name])
      rescue => e
        @controller.head :unprocessable_entity
      end
    end

    # Replaces all instances of user keys with those defined in @@user_keys
    # Supports N levels of nested maps.
    def self.replace_user_keys(map, user_keys)
      modified_map = map.clone
      map.each_pair do |key, value|
        # Sets the full template XML in the template.xml attribute
        if key == "template" || key == :template
          modified_map[key] = { :xml => template_xml }
        end

        if user_keys.has_key? key
          if map[key].instance_of? Hash
            # FIXME Using recursion in this way increases heap memory usage.
            # If we decide to stick with this approach a more memory efficient
            # implementation should be considered.
            modified_map[key] = replace_user_keys(map[key], user_keys)
          elsif map[key].instance_of? Array
            modified_map[key] = map[key].collect { |v| replace_user_keys(v, user_keys)}
          end
          modified_map[user_keys[key]] = modified_map.delete(key)
        end
      end
      modified_map
    end

    # We are storing raw XML in the templates.xml attributes.  Therefore we
    # must retrieve the raw XML from the request body.
    def self.set_template_params(resource_name)
      if resource_name == :template
        @controller.params[:template] = { :xml => template_xml }
      end
    end

    def self.template_xml
      ::Nokogiri::XML(@controller.request.body.read).xpath("//template").to_xml
    end
  end
end