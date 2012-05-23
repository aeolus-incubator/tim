module ImageManagement
  module ImageFactory
    class Base < ActiveResource::Base
      self.format = :json
      # TODO Verify Image Factory Certification Concerns that warrent removing SSL Verfication
      self.ssl_options = {:verify_mode  => OpenSSL::SSL::VERIFY_NONE}

      class << self
        ## Remove format from the url for resources
        def element_path(id, prefix_options = {}, query_options = nil)
          prefix_options, query_options = split_options(prefix_options) if query_options.nil?
          "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
        end

        ## Remove format from the url for collections
        def collection_path(prefix_options = {}, query_options = nil)
          prefix_options, query_options = split_options(prefix_options) if query_options.nil?
          "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
        end

        ## For a collection call, ActiveResource formatting is not
        ## compliant with Factory's output.
        def instantiate_collection(collection, prefix_options = {})
          unless collection.kind_of? Array
            [instantiate_record(collection, prefix_options)]
          else
            collection.collect! { |record| instantiate_record(record, prefix_options) }
          end
        end

        ##  The objects returned from this method are not automatically converted into ActiveResource instances - they are ordinary Hashes.
        ##  Modifications below ensures that you get ActiveResource instances.
        def get(method_name, options = {})
          object_array = connection.get(custom_method_collection_url(method_name, options), headers)
          if object_array.class.to_s=="Array"
            object_array.collect! {|record| self.class.new.load(record)}
          else
            self.class.new.load(object_array)
          end
        end

        # This approach does mean you're limited to one server at a time
        def config
          defined?(@@config) ? @@config : {}
        end
        def config=(conf={})
          @@config = conf
          self.site = @@config[:site]
        end

        # Should we use OAuth?
        def use_oauth?
          config[:consumer_key] && config[:consumer_secret] && config[:site]
        end
      end

      ## Instance Methods: (modifying the ActiveRecord::CustomMethods).
      ## This modification is same as defined in above method
      def get(method_name, options = {})
        self.class.new.load(connection.get(custom_method_element_url(method_name, options), self.class.headers))
      end

      # Modifying the url formations to make them Factory compliant
      def custom_method_element_url(method_name, options = {})
        "#{self.class.prefix(prefix_options)}#{self.class.collection_name}/#{id}/" +
        "#{method_name}#{self.class.send!(:query_string, options)}"
      end

      # Modifying the url formations to make them Factory compliant
      def self.custom_method_collection_url(method_name, options = {})
        prefix_options, query_options = split_options(options)
        url = "#{prefix(prefix_options)}#{collection_name}/#{method_name}#{query_string(query_options)}"
        url
      end
    end
  end
end
