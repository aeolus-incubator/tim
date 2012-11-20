module Tim
  class ImageVersionsController < Tim::ApplicationController
    prepend_before_filter ResourceLinkFilter.new({ :image_version => :base_image }),
                :only => [:create]

    def index
      @image_versions = Tim::ImageVersion.all unless defined? @image_versions
      respond_with @image_versions
    end

    def show
      @image_version = Tim::ImageVersion.find(params[:id]) unless defined? @image_version
      respond_with @image_version
    end

    def new
      @image_version = Tim::ImageVersion.new unless defined? @image_version
      respond_with @image_version
    end

    def edit
      @image_version = Tim::ImageVersion.find(params[:id]) unless defined? @image_version
      respond_with @image_version
    end

    def create
      @image_version = ImageVersion.new(params[:image_version]) unless defined? @image_version
      if @image_version.save
        flash[:notice] = 'Image version was successfully created.'
      end
      respond_with @image_version
    end

    def update
      @image_version = Tim::ImageVersion.find(params[:id]) unless defined? @image_version
      if @image_version.update_attributes(params[:image_version])
        flash[:notice] = 'Image version was successfully updated.'
      end
      respond_with @image_version
    end

    def destroy
      @image_version = Tim::ImageVersion.find(params[:id]) unless defined? @image_version
      @image_version.destroy
      respond_with @image_version
    end

  end
end
