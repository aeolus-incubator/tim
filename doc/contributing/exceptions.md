# Exception/Error handling in Tim
Contributers please follow this guide for handling errors and exceptions in Tim.

## Raising
There are many reasons your code may encounter an error, It could be that:
* An assumption you have made is turns out to be not true
* An invalid parameter is passed
* Some other reasons specific to your code

If your code does encounter an error it should deal with it appropriately.  It's perfectly reasonable to raise an exception.  If the list of already defined exceptions does not correctly describe the error you encountered or the error is specific to Tim code, you should define a new exception.  Tim exceptions are defined in the exceptions.rb found under tim/app/exceptions/tim/error directory:

```ruby
tim/app/exceptions/tim/error/exceptions.rb

module Tim
  module Error
    class DeleteFailed < StandardError; end
    class MySpecificError < StandardError; end
  end
end

```

##  Re-raising and wrapping
If for any reason you catch exceptions that are not relevant in the context of your code you should re-raise it and let it propogate up.  If an exception is thrown that has a different meaning in the context of your code, then you should wrap it in an appropriate exception and raise it.

## Logging
When ever an exception is caught and not re-raised, you should log the stacktrace and optionally an error to explain the issue.  Do not log the error if you intend to re-raise it or wrap it and raise it.  Since this could result in a ton of log entries.

## REST API
If an exception propogates up to the REST API boundary, (This will most likely be at the controller level) it should be caught, logged and an appropriate response code with an error body returned (see: app/views/layouts/errors.rb).

## Swallowing Exceptions
Swallowing exceptions is generally bad practice, however, there are times when swallowing an exception is a perfectly reasonable thing to do.  These scenarios should be infrequent, if you are swallowing a lot of exceptions then it usually means you are not following this guide properly.

### When is swallowing exceptions appropriate?
If you are creating a method that expects some exception (or an exception is a valid expectation) then you are safe to catch the exception and not log it (i.e. Swallow it).  These scenarios should be infrequent.  One example of an appropriate time to swallow could be something like as follows:

```ruby
def can_connect_to_imagefactory?
  begin
    Tim::TargetImage.find(1)
    true
  rescue ActiveResource::ConnectionError
    false
  rescue => e
    return true if is_active_resource_error?(e)
    raise e
  end
end
```

In the above rather contrived example any ActiveResource error is an acceptable response.  This is the expected behaviour:

* **Tim can not connect to the server:** In this case we would expect to see an ActiveResource::ConnectionError and so we can return false.
* **Server returns a successful response:** In this case the TargetImage is found and a success response is returned from the server.  Therefore we can return true
* **Server returns a unsuccessful response:** This would result in any of the other ActiveResource errors.  This is expected so we can catch it and return true.
* **Some unknown error happens:** If this is the case we re-raise error and allow it to filter up.