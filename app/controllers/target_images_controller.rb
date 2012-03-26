class TargetImagesController < ApplicationController
  # GET /target_images
  # GET /target_images.json
  def index
    @target_images = TargetImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @target_images }
    end
  end

  # GET /target_images/1
  # GET /target_images/1.json
  def show
    @target_image = TargetImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @target_image }
    end
  end

  # GET /target_images/new
  # GET /target_images/new.json
  def new
    @target_image = TargetImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @target_image }
    end
  end

  # GET /target_images/1/edit
  def edit
    @target_image = TargetImage.find(params[:id])
  end

  # POST /target_images
  # POST /target_images.json
  def create
    @target_image = TargetImage.new(params[:target_image])

    respond_to do |format|
      if @target_image.save
        format.html { redirect_to @target_image, :notice => 'Target image was successfully created.' }
        format.json { render :json => @target_image, :status => :created, :location => @target_image }
      else
        format.html { render :action => "new" }
        format.json { render :json => @target_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /target_images/1
  # PUT /target_images/1.json
  def update
    @target_image = TargetImage.find(params[:id])

    respond_to do |format|
      if @target_image.update_attributes(params[:target_image])
        format.html { redirect_to @target_image, :notice => 'Target image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @target_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /target_images/1
  # DELETE /target_images/1.json
  def destroy
    @target_image = TargetImage.find(params[:id])
    @target_image.destroy

    respond_to do |format|
      format.html { redirect_to target_images_url }
      format.json { head :no_content }
    end
  end
end
