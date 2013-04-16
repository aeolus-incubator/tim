# Tim Object Model

Please read: [REST API Reference](https://github.com/aeolus-incubator/tim/wiki/api-reference) for description of all the objects in Tim.

As well as through the API, you can access all Tim models from Ruby code.  All the models are namespaced under Tim.  e.g.

```ruby
  Tim::Template.new
```

## Templates
The template object has a one to many mapping with BaseImages.  i.e.  One Template can have many BaseImages, a BaseImage can have a single template.

The Template model has a single field called xml.  The xml stores the TDL for this template.

```ruby
  template_xml = "<template><name>mock</name><os><name>RHELMock</name><version>1</version><arch>x86_64</arch><install type=\"iso\"><iso>http://mockhost/RHELMock1-x86_64-DVD.iso</iso></install><rootpw>password</rootpw></os><description>Mock Template</description></template>"

  template = Tim::Template.create(:xml => template_xml)
```

## BaseImage

```ruby
base_image = Tim::BaseImage.new(:name => "BaseImage")
base_image.template = template
base_image.save
```

## Image Versions

```ruby
image_version = Tim::ImageVersion.new
image_version.base_image = base_image
image_version.save
```

## TargetImages
```ruby
target_image = Tim::TargetImage.new(:target => "MockSphere")
target_image.image_version = image_version
target_image.save
```

## Provider Image
```ruby
provider_image1 = Tim::ProviderImage.new(:provider => "MockSphere")
provider_image1.provider_account = provider_account
provider_image1.target_image = target_image
provider_image1.save
```