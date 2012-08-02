# This is not needed in rails 3.2.3
module ActiveResource
  module Formats
    # Lifted from ActiveResource 3.2.3.  Needed for base.rb patch.
    def self.remove_root(data)
      if data.is_a?(Hash) && data.keys.size == 1
        data.values.first
      else
        data
      end
    end
  end
end