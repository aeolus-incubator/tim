require 'nokogiri'

module Tim
  class BaseImagesController < ApplicationController
    append_before_filter :set_template_xml, :only => [:create, :update]

    def index
      @base_images = Tim::BaseImage.all unless defined? @base_images
      respond_with @base_images
    end

    def show
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      respond_with @base_image
    end

    def new
      @base_image = Tim::BaseImage.new
      respond_with @base_image
    end

    def edit
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      respond_with @base_image
    end

    def create
      @base_image = Tim::BaseImage.new(params[:base_image]) unless defined? @base_image
      if @base_image.save
        flash[:notice] = "Successfully created Base Image"
      end
      respond_with @base_image
    end

    def update
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      if @base_image.update_attributes(params[:base_image])
        flash[:notice] = "Successfully updated Base Image"
      end
      respond_with @base_image
    end

    def destroy
      @base_image = Tim::BaseImage.find(params[:id]) unless defined? @base_image
      @base_image.destroy
      respond_with(@base_image)
    end

    private
    # Handles the cases when the template xml is supplied within request
    def set_template_xml
      doc = ::Nokogiri::XML request.body.read
      if !doc.xpath("//base_image/template").empty?
        params[:base_image][:template] = { :xml => doc.xpath("//base_image/template").children.to_s}
      end
    end

  end
end
