module Tim
  class TargetImagesController < ApplicationController
    respond_to :json, :only => :update

    before_filter :factory_keys, :only => :update

    def index
      @target_images = Tim::TargetImage.all unless defined? @target_images
      respond_with @target_images
    end

    def show
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      respond_with @target_image
    end

    def new
      @target_image = Tim::TargetImage.new unless defined? @target_image
      respond_with @target_image
    end

    def edit
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      respond_with @target_image
    end

    def create
      @target_image = TargetImage.new(params[:target_image]) unless defined? @target_image
      if @target_image.save
        flash[:notice] = 'Image version was successfully created.'
      end
      respond_with @target_image
    end

    def update
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      if @target_image.update_attributes(params[:target_image])
        flash[:notice] = 'Target image was successfully updated.'
      end
      respond_with @target_image
    end

    # DELETE /target_images/1
    # DELETE /target_images/1.xml
    def destroy
      @target_image = Tim::TargetImage.find(params[:id]) unless defined? @target_image
      @target_image.destroy
      respond_with @target_image
    end

    # TODO Add factory permission check
    def factory_keys
      if params[:target_image][:percent_complete] && params[:target_image][:status_detail][:activity]
        params[:target_image][:progress] = params[:target_image].delete(:percent_complete)
        params[:target_image][:status_detail] = params[:target_image][:status_detail].delete(:activity)
        params[:target_image][:status] = params[:target_image].delete(:status)
      end
    end

  end
end