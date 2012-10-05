module Tim
  class ProviderImagesController < ApplicationController
    respond_to :json, :only => :update

    before_filter :factory_keys, :only => :update

    def index
      @provider_images = Tim::ProviderImage.all unless defined? @provider_images
      respond_with @provider_images
    end

    def show
      @provider_image = Tim::ProviderImage.find(params[:id]) unless defined? @provider_image
      respond_with @provider_image
    end

    def new
      @provider_image = Tim::ProviderImage.new
      respond_with @provider_image
    end

    def edit
      @provider_image = Tim::ProviderImage.find(params[:id]) unless defined? @provider_image
      respond_with @provider_image
    end

    def create
      @provider_image = ProviderImage.new(params[:provider_image]) unless defined? @provider_image
      if @provider_image.save
        flash[:notice] = 'Image version was successfully created.'
      end
      respond_with @provider_image
    end

    def update
      @provider_image = Tim::ProviderImage.find(params[:id]) unless defined? @provider_image
      if @provider_image.update_attributes(params[:provider_image])
        flash[:notice] = 'Provider image was successfully updated.'
      end
      respond_with @provider_image
    end

    def destroy
      @provider_image = Tim::ProviderImage.find(params[:id]) unless defined? @provider_image
      @provider_image.destroy
      respond_with @provider_image
    end

    private
    # TODO Add factory permission check
    def factory_keys
      if params[:provider_image][:percent_complete] && params[:provider_image][:status_detail][:activity]
        params[:provider_image] = { :progress => params[:provider_image][:percent_complete],
                                    :status_detail => params[:provider_image][:status_detail][:activity],
                                    :status => params[:provider_image][:status] }
      end
    end
  end
end