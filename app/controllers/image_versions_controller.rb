class ImageVersionsController < ApplicationController
  # GET /image_versions
  # GET /image_versions.json
  def index
    @image_versions = ImageVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @image_versions }
    end
  end

  # GET /image_versions/1
  # GET /image_versions/1.json
  def show
    @image_version = ImageVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @image_version }
    end
  end

  # GET /image_versions/new
  # GET /image_versions/new.json
  def new
    @image_version = ImageVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @image_version }
    end
  end

  # GET /image_versions/1/edit
  def edit
    @image_version = ImageVersion.find(params[:id])
  end

  # POST /image_versions
  # POST /image_versions.json
  def create
    @image_version = ImageVersion.new(params[:image_version])

    respond_to do |format|
      if @image_version.save
        format.html { redirect_to @image_version, :notice => 'Image version was successfully created.' }
        format.json { render :json => @image_version, :status => :created, :location => @image_version }
      else
        format.html { render :action => "new" }
        format.json { render :json => @image_version.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /image_versions/1
  # PUT /image_versions/1.json
  def update
    @image_version = ImageVersion.find(params[:id])

    respond_to do |format|
      if @image_version.update_attributes(params[:image_version])
        format.html { redirect_to @image_version, :notice => 'Image version was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @image_version.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /image_versions/1
  # DELETE /image_versions/1.json
  def destroy
    @image_version = ImageVersion.find(params[:id])
    @image_version.destroy

    respond_to do |format|
      format.html { redirect_to image_versions_url }
      format.json { head :no_content }
    end
  end
end
