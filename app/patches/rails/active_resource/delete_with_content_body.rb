module ActiveResource
  # Add a method that enables deletion with content body to
  # ActiveRecord::Connection
  class Connection
    def delete_with_body(path, body = '', headers = {})
      with_auth { request(:delete, path, body.to_s, build_request_headers(headers, :delete, self.site.merge(path))) }
    end

    def request(method, path, *arguments)
      result = ActiveSupport::Notifications.instrument("request.active_resource") do |payload|
        payload[:method]      = method
        payload[:request_uri] = "#{site.scheme}://#{site.host}:#{site.port}#{path}"
        if method == :delete && arguments.size > 1
          payload[:result]      = http.delete_with_body(path, *arguments)
        else
          payload[:result]      = http.send(method, path, *arguments)
        end
      end
      handle_response(result)
    rescue Timeout::Error => e
      raise TimeoutError.new(e.message)
    rescue OpenSSL::SSL::SSLError => e
      raise SSLError.new(e.message)
    end
  end

  # Override ActiveRecord::Base to check to content_body parameter.  If its true
  # then encode the body of the object and set it in the content body of the
  # delete request
  class Base
    def destroy_with_body
      connection.delete_with_body(element_path, encode, self.class.headers)
    end
  end

end

module Net
  class HTTP
    def delete_with_body(path, body, initheader = {'Depth' => 'Infinity'})
      req = Delete.new(path, initheader)
      req.body = body
      req.content_type = 'application/json'
      request(req)
    end
  end
end