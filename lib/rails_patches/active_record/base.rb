# TODO Check to see if nested attr issue is solved in Rails v2.3
module ActiveRecord
  class Base
    def self.new(attributes={})
      resource = super({})
      resource.attributes = created_nested_resources(resource, attributes)
      resource
    end

    def self.create(attributes={})
      resource = new(attributes)
      resource.save!
      resource
    end

    def update_attributes(attributes={})
      super(self.class.created_nested_resources(self, attributes))
    end

    # Lifted from ActiveResource::Base and Added support for :class_name
    def self.accepts_nested_attributes_for(*attr_names)
      options = { :allow_destroy => false, :update_only => false, :class_name => nil }
      options.update(attr_names.extract_options!)
      options.assert_valid_keys(:allow_destroy, :reject_if, :limit, :update_only, :class_name)
      options[:reject_if] = REJECT_ALL_BLANK_PROC if options[:reject_if] == :all_blank

      attr_names.each do |association_name|
        if reflection = reflect_on_association(association_name)
          reflection.options[:autosave] = true
          add_autosave_association_callbacks(reflection)
          nested_attributes_options[association_name.to_sym] = options
          type = (reflection.collection? ? :collection : :one_to_one)

          # def pirate_attributes=(attributes)
        #   assign_nested_attributes_for_one_to_one_association(:pirate, attributes)
        # end
        class_eval <<-eoruby, __FILE__, __LINE__ + 1
          if method_defined?(:#{association_name}_attributes=)
            remove_method(:#{association_name}_attributes=)
          end
          def #{association_name}_attributes=(attributes)
            assign_nested_attributes_for_#{type}_association(:#{association_name}, attributes)
          end
        eoruby
      else
        raise ArgumentError, "No association found for name `#{association_name}'. Has it been define
      d yet?"
        end
      end
    end

    private
    # TODO Add support for one to many relational attributes
    def self.created_nested_resources(resource, attributes={})
      self.nested_attributes_options.each_pair do | key, value |
        if value[:class_name] && (attributes.keys.include?(key.to_s) || attributes.keys.include?(key))
          if nested_resource = create_nested_resource(value[:class_name], (attributes.delete(key.to_s)) || attributes.delete(key))
            resource.send(key.to_s + "=", nested_resource)
          end
        end
      end
      attributes
    end

    def self.create_nested_resource(class_name, attributes={})
      clazz = class_name.constantize
      if !attributes.empty?
        if id = attributes[:id]
          t = clazz.find(id)
          t.update_attributes(id)
          t
        else
          clazz.new(attributes)
        end
      else
        nil
      end
    end

  end
end