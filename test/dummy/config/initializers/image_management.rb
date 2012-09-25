ImageManagement.user_class = "User"
ImageManagement.provider_account_class = "ProviderAccount"
ImageManagement.provider_type_class = "ProviderType"
# Image Factory URL
ImageManagement::ImageFactory::Base.site = "http://localhost:8075/imagefactory"
# FIXME: We should be able to infer these from Routes
ImageManagement::ImageFactory::TargetImage.callback_url = "http://localhost:3000/target_images/"
ImageManagement::ImageFactory::ProviderImage.callback_url = "http://localhost:3000/provider_images/"
