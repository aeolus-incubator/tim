require 'nokogiri'

module Tim
  class BaseImagesController < Tim::ApplicationController
    prepend_before_filter ResourceLinkFilter.new({ :base_image => :template }),
                :only => [:create]

    def index
      @base_images = Tim::BaseImage.all unless defined? @base_images
      respond_with @base_images
    end

    def show
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      respond_with @base_image
    end

    def new
      @base_image = Tim::BaseImage.new unless defined? @base_image
      respond_with @base_image
    end

    def edit
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      respond_with @base_image
    end

    def create
      @base_image = Tim::BaseImage.new(params[:base_image]) unless defined? @base_image
      if @base_image.save
        flash[:notice] = "Successfully created Base Image"
      end
      respond_with @base_image
    end

    def update
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      if @base_image.update_attributes(params[:base_image])
        flash[:notice] = "Successfully updated Base Image"
      end
      respond_with @base_image
    end

    def destroy
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      @base_image.destroy
      respond_with(@base_image)
    end

  end
end
