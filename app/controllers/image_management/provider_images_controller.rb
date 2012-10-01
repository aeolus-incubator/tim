module ImageManagement
  class ProviderImagesController < ApplicationController
    before_filter :factory_keys, :only => :update

    # GET /provider_images
    # GET /provider_images.xml
    def index
      @provider_images = ImageManagement::ProviderImage.all unless defined? @provider_images

      respond_to do |format|
        format.html # index.html.erb
        format.xml # index.xml
      end
    end

    # GET /provider_images/1
    # GET /provider_images/1.xml
    def show
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image

      respond_to do |format|
        format.html # show.html.erb
        format.xml # show.xml
      end
    end

    # GET /provider_images/new
    # GET /provider_images/new.xml
    def new
      @provider_image = ImageManagement::ProviderImage.new

      respond_to do |format|
        format.html # new.html.erb
      end
    end

    # GET /provider_images/1/edit
    def edit
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image
    end

    # POST /provider_images
    # POST /provider_images.xml
    def create
      respond_to do |format|
        begin
          @provider_image = ProviderImage.new(params[:provider_image]) unless defined? @provider_image
          if @provider_image.save
            format.html { redirect_to image_management_target_image_path(@provider_image), :notice => 'Image version was successfully created.' }
            format.xml { render :action => "show", :status => :created }
          else
            format.html { render :action => "new" }
            format.xml { render :xml => @provider_image.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in application controller
        rescue => e
          if e.instance_of? ActiveRecord::RecordNotFound
            raise e
          else
            format.html { render :action => "new" }
            format.xml { render :xml => e.message, :status => :unprocessable_entity }
          end
        end
      end
    end

    # PUT /provider_images/1
    # PUT /provider_images/1.xml
    def update
      respond_to do |format|
        begin
          @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image

          @provider_image.update_attributes(params[:provider_image])
          if @provider_image.save
            format.html { redirect_to @provider_image, :notice => 'Provider image was successfully updated.' }
            format.xml { render :action => "show" }
            format.json { render :json => @provider_image }
          else
            format.html { render :action => "edit" }
            format.xml { render :xml => @provider_image.errors, :status => :unprocessable_entity }
            format.json { render :json => @provider_image.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in appliation controller
        rescue => e
          raise e if e.instance_of? ActiveRecord::RecordNotFound
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
          format.json { render :json => e.message, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /provider_images/1
    # DELETE /provider_images/1.xml
    def destroy
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image
      @provider_image.destroy

      respond_to do |format|
        format.html { redirect_to image_management_provider_images_url }
        format.xml { head :no_content }
      end
    end

    private
    # TODO Add factory permission check
    def factory_keys
      if params[:provider_image][:percent_complete] && params[:provider_image][:status_detail][:activity]
        params[:provider_image][:progress] = params[:provider_image].delete(:percent_complete)
        params[:provider_image][:status_detail] = params[:provider_image].delete(:status_detail)[:activity]
        params[:provider_image][:status] = params[:provider_image].delete(:status)
      end
    end
  end
end