# Sets up use_route across controller tests, from:
# http://bit.ly/PU4Wm4 (stackoverflow)

module ControllerHacks
  def get(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "GET")
  end

  # Executes a request simulating POST HTTP method and set/volley the
  # response
  def post(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "POST")
  end

  # Executes a request simulating PUT HTTP method and set/volley the
  # response
  def put(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "PUT")
  end

  # Executes a request simulating DELETE HTTP method and set/volley
  # the response
  def delete(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "DELETE")
  end

  private

  def process_action(action, parameters = nil, session = nil, flash = nil, method = "GET")
    parameters ||= {}
    process(action, parameters.merge!(:use_route => :image_management), session, flash, method)
  end
end

RSpec.configure do |c|
   # This will include the routing helpers in the specs so that we can
   # use base_image_path and so on to get to the routes.
   c.include ImageManagement::Engine.routes.url_helpers
   # Always use the correct route for controller tests
   c.include ControllerHacks, :type => :controller
end
