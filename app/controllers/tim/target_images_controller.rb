module Tim
  class TargetImagesController < Tim::ApplicationController
    respond_to :json, :only => :update

    prepend_before_filter ResourceLinkFilter.new({ :target_image => :image_version }),
                :only => [:create]
    before_filter :factory_keys, :only => :update

    def index
      @target_images = Tim::TargetImage.all unless defined? @target_images
      respond_with(@target_images, @respond_options)
    end

    def show
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      respond_with(@target_image, @respond_options)
    end

    def new
      @target_image = Tim::TargetImage.new unless defined? @target_image
      respond_with(@target_image, @respond_options)
    end

    def edit
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      respond_with(@target_image, @respond_options)
    end

    def create
      @target_image = TargetImage.new(params[:target_image]) unless defined? @target_image
      if @target_image.save
        flash[:notice] = 'Image version was successfully created.'
      end
      respond_with(@target_image, @respond_options)
    end

    def update
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      if @target_image.update_attributes(params[:target_image])
        flash[:notice] = 'Target image was successfully updated.'
      end
      respond_with(@target_image, @respond_options)
    end

    # DELETE /target_images/1
    # DELETE /target_images/1.xml
    def destroy
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      @target_image.destroy
      respond_with(@target_image, @respond_options)
    end

    # TODO Add factory permission check
    def factory_keys
      if params[:target_image][:percent_complete] && params[:target_image][:status_detail][:activity]
        params[:target_image] = { :progress => params[:target_image][:percent_complete],
                                  :status_detail => params[:target_image][:status_detail][:activity],
                                  :status => params[:target_image][:status] }
      end
    end

  end
end