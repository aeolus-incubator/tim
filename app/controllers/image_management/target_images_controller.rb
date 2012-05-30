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
          @target_image = ImageManagement::TargetImage.new(params[:target_image])

          if @target_image.save
            format.html { redirect_to image_management_target_image_path(@target_image), :notice => 'Image version was successfully created.' }
            format.xml { render :action => "show", :status => :created }
          else
            format.html { render :action => "new" }
            format.xml { render :xml => @target_image.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in appliation controller
        rescue => e
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /target_images/1
    # PUT /target_images/1.xml
    def update
      respond_to do |format|
        begin
          @target_image = ImageManagement::TargetImage.find(params[:id])

          if @target_image.update_attributes(params[:target_image])
            format.html { redirect_to @target_image, :notice => 'Target image was successfully updated.' }
            format.xml { head :no_content }
          else
            format.html { render :action => "edit" }
            format.xml { render :xml => @target_image.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in appliation controller
        rescue => e
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
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