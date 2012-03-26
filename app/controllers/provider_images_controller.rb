class ProviderImagesController < ApplicationController
  # GET /provider_images
  # GET /provider_images.json
  def index
    @provider_images = ProviderImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @provider_images }
    end
  end

  # GET /provider_images/1
  # GET /provider_images/1.json
  def show
    @provider_image = ProviderImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @provider_image }
    end
  end

  # GET /provider_images/new
  # GET /provider_images/new.json
  def new
    @provider_image = ProviderImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @provider_image }
    end
  end

  # GET /provider_images/1/edit
  def edit
    @provider_image = ProviderImage.find(params[:id])
  end

  # POST /provider_images
  # POST /provider_images.json
  def create
    @provider_image = ProviderImage.new(params[:provider_image])

    respond_to do |format|
      if @provider_image.save
        format.html { redirect_to @provider_image, :notice => 'Provider image was successfully created.' }
        format.json { render :json => @provider_image, :status => :created, :location => @provider_image }
      else
        format.html { render :action => "new" }
        format.json { render :json => @provider_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /provider_images/1
  # PUT /provider_images/1.json
  def update
    @provider_image = ProviderImage.find(params[:id])

    respond_to do |format|
      if @provider_image.update_attributes(params[:provider_image])
        format.html { redirect_to @provider_image, :notice => 'Provider image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @provider_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /provider_images/1
  # DELETE /provider_images/1.json
  def destroy
    @provider_image = ProviderImage.find(params[:id])
    @provider_image.destroy

    respond_to do |format|
      format.html { redirect_to provider_images_url }
      format.json { head :no_content }
    end
  end
end
