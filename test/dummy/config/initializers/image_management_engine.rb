############################## Image Management Engine Initializer ################################

# Image Factory URL
ImageManagement::ImageFactory::Base.site = "http://localhost:8075/imagefactory"

# TODO We should be able to infer these from Routes
ImageManagement::ImageFactory::TargetImage.callback_url = "http://localhost:3000/target_images/"
ImageManagement::ImageFactory::ProviderImage.callback_url = "http://localhost:3000/provider_images/"