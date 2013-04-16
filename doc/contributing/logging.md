# Logging in Tim

Logging is extremely useful for debugging, both in development and in production environments.  Patches submitted to Tim should contain a reasonable amount of logging.  There is no definitive guide on when and when not to use logging.  You can look at current Tim code to get an idea of what is acceptable.  In general logging will be used to locate errors, bugs in the code and for tracing the route through the code, so keep that in mind when coding.

## The Logger

Tim uses the Ruby standard logger.

Rails makes a logger available in pretty much anything that inherits from a Rails class.  i.e. ActiveRecord::Base, ActiveRecord::Controller.  You can use this via the `logger` method.

``` ruby
class Foo < ActiveRecord::Base
  def bar
    logger.debug "Processing Foo.bar"
  end
end
```

For classes that do not inherit from Rails you can still use the helper method, but as a class method of Rails or you can use the constant `RAILS_DEFAULT_LOGGER`.  

``` ruby
class Foo
  def bar
    Rails.logger.debug "Processing Foo.bar"
    RAILS_DEFAULT_LOGGER.debug "Processing Foo.bar"
  end
end
```

To keep consistency we will use only the `Rails.logger.debug "Processing Foo.bar"` method.
## Logging Exceptions

You should always log exception that are not propogated up and not expected.  See: [Exception Handling in Tim](https://github.com/aeolus-incubator/tim/wiki/Exception-Handling-in-Tim) guide for more info

## Log Levels

If you are not familiar with log levels you can refer to this list to get an idea of the correct log level to use in your code.

Lifted straight from: http://en.wikipedia.org/wiki/Log4j

Level Description
* **FATAL:**  Severe errors that cause premature termination. Expect these to be immediately visible on a status console.
* **ERROR:**  Other runtime errors or unexpected conditions. Expect these to be immediately visible on a status console.
* **WARN:** Use of deprecated APIs, poor use of API, 'almost' errors, other runtime situations that are undesirable or unexpected, but not necessarily "wrong". Expect these to be immediately visible on a status console.
* **INFO:** Interesting runtime events (startup/shutdown). Expect these to be immediately visible on a console, so be conservative and keep to a minimum.
* **DEBUG:**  Detailed information on the flow through the system. Expect these to be written to logs only.
* **TRACE:**  Most detailed information. Expect these to be written to logs only. Since version 1.2.12.