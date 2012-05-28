module ImageManagement
  class ImageVersionsController < ApplicationController
    # GET /image_versions
    # GET /image_versions.xml
    def index
      @image_versions = ImageManagement::ImageVersion.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml # index.xml
      end
    end

    # GET /image_versions/1
    # GET /image_versions/1.xml
    def show
      @image_version = ImageManagement::ImageVersion.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml # show.xml
      end
    end

    # GET /image_versions/new
    # GET /image_versions/new.xml
    def new
      @image_version = ImageManagement::ImageVersion.new

      respond_to do |format|
        format.html # new.html.erb
      end
    end

    # GET /image_versions/1/edit
    def edit
      @image_version = ImageManagement::ImageVersion.find(params[:id])
    end

    # POST /image_versions
    # POST /image_versions.xml
    def create
      respond_to do |format|
        begin
          @image_version = ImageManagement::ImageVersion.new(params[:image_version])

          if @image_version.save
            format.html { redirect_to image_management_image_version_path(@image_version), :notice => 'Image version was successfully created.' }
            format.xml { render :action => "show", :status => :created }
          else
            format.html { render :action => "new" }
            format.xml { render :xml => @image_version.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in appliation controller
        rescue => e
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /image_versions/1
    # PUT /image_versions/1.xml
    def update
      respond_to do |format|
        begin
          @image_version = ImageManagement::ImageVersion.find(params[:id])

          if @image_version.update_attributes(params[:image_version])
            format.html { redirect_to @image_version, :notice => 'Image version was successfully updated.' }
            format.xml { head :no_content }
          else
            format.html { render :action => "edit" }
            format.xml { render :xml => @image_version.errors, :status => :unprocessable_entity }
          end
        # TODO Add in proper exception handling in appliation controller
        rescue => e
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /image_versions/1
    # DELETE /image_versions/1.xml
    def destroy
      @image_version = ImageManagement::ImageVersion.find(params[:id])
      @image_version.destroy

      respond_to do |format|
        format.html { redirect_to image_management_image_versions_url }
        format.xml { head :no_content }
      end
    end

  end
end