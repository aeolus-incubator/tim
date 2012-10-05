Tim.user_class = "User"
Tim.provider_account_class = "ProviderAccount"
Tim.provider_type_class = "ProviderType"
# Image Factory URL
Tim::ImageFactory::Base.site = "http://localhost:8075/imagefactory"
# FIXME: We should be able to infer these from Routes
Tim::ImageFactory::TargetImage.callback_url = "http://localhost:3000/tim/target_images/"
Tim::ImageFactory::ProviderImage.callback_url = "http://localhost:3000/tim/provider_images/"
