module ImageManagement
  class TargetImagesController < ApplicationController
    # GET /target_images
    # GET /target_images.xml
    def index
      @target_images = ImageManagement::TargetImage.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml # index.xml
      end
    end

    # GET /target_images/1
    # GET /target_images/1.xml
    def show
      @target_image = ImageManagement::TargetImage.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml # show.xml
      end
    end

    # GET /target_images/new
    # GET /target_images/new.xml
    def new
      @target_image = ImageManagement::TargetImage.new

      respond_to do |format|
        format.html # new.html.erb
      end
    end

    # GET /target_images/1/edit
    def edit
      @target_image = ImageManagement::TargetImage.find(params[:id])
    end

    # POST /target_images
    # POST /target_images.xml
    def create
      respond_to do |format|
        begin
          # We check for base image manually, a restriction caused by the
          # ActiveRecord::Base Patch 
          # TODO Remove when modules are supported in ActiveRecord
          if params[:target_image][:image_version] && params[:target_image][:image_version][:id]
            image_version = ImageManagement::ImageVersion.find(params[:target_image].delete(:image_version)[:id])
            @target_image = ImageManagement::TargetImage.new(params[:target_image])
            @target_image.image_version = image_version
          else
            @target_image = ImageManagement::TargetImage.new(params[:target_image])
          end

          if @target_image.save
            format.html { redirect_to image_management_target_image_path(@target_image), :notice => 'Image version was successfully created.' }
            format.xml { render :action => "show", :status => :created }
          else
            format.html { render :action => "new" }
            format.xml { render :xml => @target_image.errors, :status => :unprocessable_entity }
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

    # PUT /target_images/1
    # PUT /target_images/1.xml
    def update
      respond_to do |format|
        begin
          @target_image = ImageManagement::TargetImage.find(params[:id])

          # Check for factory params.  Modify param names.
          if params[:target_image][:percent_complete] && params[:target_image][:status_detail][:activity]
            @target_image.progress = params[:target_image].delete(:percent_complete)
            @target_image.status_detail = params[:target_image][:status_detail].delete(:activity)
            @target_image.status = params[:target_image].delete(:status)
          end

          # We check for base image manually, a restriction caused by the
          # ActiveRecord::Base Patch 
          # TODO Remove when modules are supported in ActiveRecord
          if params[:target_image][:image_version] && params[:target_image][:image_version][:id]
            image_version = ImageVersion.find(params[:target_image].delete(:image_version)[:id])
            @target_image.image_version = image_version
          end

          @target_image.attributes = params[:target_image]
          if @target_image.save
            format.html { redirect_to @target_image, :notice => 'Target image was successfully updated.' }
            format.xml { render :action => "show" }
            format.json { render :json => @target_image }
          else
            format.html { render :action => "edit" }
            format.xml { render :xml => @target_image.errors, :status => :unprocessable_entity }
            format.json { render :json => @target_image.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in appliation controller
        rescue => e
          raise e if e.instance_of? ActiveRecord::RecordNotFound
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
          format.json { render :json => @target_image.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /target_images/1
    # DELETE /target_images/1.xml
    def destroy
      @target_image = ImageManagement::TargetImage.find(params[:id])
      @target_image.destroy

      respond_to do |format|
        format.html { redirect_to image_management_target_images_url }
        format.xml { head :no_content }
      end
    end

  end
end