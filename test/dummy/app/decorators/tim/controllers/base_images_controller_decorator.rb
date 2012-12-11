Tim::BaseImagesController.class_eval do
  before_filter :set_test_location, :only => :respond_options_test

  def respond_options_test
    @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
    respond_with(@base_image, @respond_options)
  end

  private
  def set_test_location
    @respond_options = {:location => tim.templates_path}
  end
end