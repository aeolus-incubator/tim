Tim.user_class = "User"
Tim.provider_account_class = "ProviderAccount"
Tim.provider_type_class = "ProviderType"

# Image Factory URL
Tim::ImageFactory::Base.site = "http://localhost:8075/imagefactory"

# Example OAuth Configuration
#oauth_config = {:consumer_key => "mock-key",
#                :consumer_secret => "mock-secret",
#                :site => "http://localhost:8075/imagefactory/"}#
#Tim::ImageFactory::Base.config = oauth_config

# FIXME: We should be able to infer these from Routes
Tim::ImageFactory::TargetImage.callback_url = "http://localhost:3000/tim/target_images/"
Tim::ImageFactory::ProviderImage.callback_url = "http://localhost:3000/tim/provider_images/"