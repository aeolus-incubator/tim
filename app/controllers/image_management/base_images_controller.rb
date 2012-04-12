module ImageManagement
  class BaseImagesController < ApplicationController
    # GET /base_images
    # GET /base_images.json
    def index
      @base_images = ImageManagement::BaseImage.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @base_images }
      end
    end

    # GET /base_images/1
    # GET /base_images/1.json
    def show
      @base_image = ImageManagement::BaseImage.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @base_image }
      end
    end

    # GET /base_images/new
    # GET /base_images/new.json
    def new
      @base_image = ImageManagement::BaseImage.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @base_image }
      end
    end

    # GET /base_images/1/edit
    def edit
      @base_image = ImageManagement::BaseImage.find(params[:id])
    end

    # POST /base_images
    # POST /base_images.json
    def create
      @base_image = ImageManagement::BaseImage.new(params[:base_image])

      respond_to do |format|
        if @base_image.save
          format.html { redirect_to @base_image, :notice => 'Base image was successfully created.' }
          format.json { render :json => @base_image, :status => :created, :location => @base_image }
        else
          format.html { render :action => "new" }
          format.json { render :json => @base_image.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /base_images/1
    # PUT /base_images/1.json
    def update
      @base_image = ImageManagement::BaseImage.find(params[:id])

      respond_to do |format|
        if @base_image.update_attributes(params[:base_image])
          format.html { redirect_to @base_image, :notice => 'Base image was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @base_image.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /base_images/1
    # DELETE /base_images/1.json
    def destroy
      @base_image = ImageManagement::BaseImage.find(params[:id])
      @base_image.destroy

      respond_to do |format|
        format.html { redirect_to image_management_base_images_url }
        format.json { head :no_content }
      end
    end
  end
end