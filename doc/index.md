Tim is a Rails Engine responsible for Cloud image management.  It
allows clients to create, delete and upload images to a multitude of
Cloud providers.  Tim builds on top of Imagefactory’s cloud
abstraction layer.

Adding the ability for clients to store meta-data (used for searching
and sorting) as well as versioning and support for access control.
Tim wraps all this up in a clean, simply RESTful API.

You can read the full presentation [here](http://www.aeolusproject.org/docs/presentations/2012-nov-conference/tim.odp).

## Configuration

### Setting Up Factory

Please read our guide found [here](getting_started/imagefactory_setup.md)

### Securing Image Factory requests

It is possible to secure Image Factory requests using 2 Legged OAuth.  To use 2
Legged OAuth you must set the OAuth consumer key, consumer secret and url in the
Tim::ImageFactory::Base.config.

#### Example:
```ruby
  oauth_config = {:consumer_key => "mock-key",
                  :consumer_secret => "mock-secret",
                  :site => "http://localhost:8075/imagefactory/"}
  Tim::ImageFactory::Base.config = oauth_config
```
## Running Tests

[<img src="https://secure.travis-ci.org/aeolus-incubator/tim.png"
alt="Build Status" />](http://travis-ci.org/aeolus-incubator/tim])

Tests are run from the project root directory.  But are run in the
context of the dummy app located under test/dummy.  In order to run
the tests you must first setup dummy app database.

```ruby
  rake db:setup; rake -f test/dummy/Rakefile test:prepare
```

Once you have done this cd to the project root and run the following:

```ruby
  rake spec
```

## Running the Dummy app

This will allow you to runn the commands below to test out the engine
in isolation (if mounted in another application, the main difference
will just be where the engine gets mounted, so adjust your url
accordingly).

cd test/dummy; rails s

## API

* [Object Model](api/object_model.md)
* [REST API](api/rest/index.md)
* [Ruby API](api/ruby/index.md)

## Generating State Machines Images

From test/dummy run:

```ruby
  rake state_machine:draw FILE=../../app/models/tim/target_image.rb CLASS=Tim::TargetImage
  rake state_machine:draw FILE=../../app/models/tim/provider_image.rb CLASS=Tim::ProviderImage
```

## Contributing

We encourage you to contribute to Tim.  We are open to new ideas and
features (especially if you offer to implement them!) as well as
{Github issues}[https://github.com/aeolus-incubator/tim/issues/] to point
us at any bugs that may be encountered.

[Read our contributer guide to get started](contributing/index.md)


## License

Image Management Engine is released under the MIT license.
