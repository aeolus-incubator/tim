module ImageManagement
  class TemplatesController < ApplicationController
    before_filter :template_params, :only => [:update, :create]

    def index
      @templates = ImageManagement::Template.all unless defined? @templates
      respond_with @templates
    end

    def show
      @template = ImageManagement::Template.find(params[:id]) unless defined? @template
      respond_with @template
    end

    def new
      @template = ImageManagement::Template.new unless defined? @template
      respond_with @template
    end

    def edit
      @template = ImageManagement::Template.find(params[:id])
      respond_with @template
    end

    def create
      @template = ImageManagement::Template.new(params[:template]) unless defined? @template
      if @template.save
        flash[:notice] = 'Template was successfully created.'
      end
      respond_with @template
    end

    def update
      @template = ImageManagement::Template.find(params[:id]) unless defined? @template
      if @template.update_attributes(params[:template])
        flash[:notice] = 'Template was successfully updated.'
      end
      respond_with @template
    end

    def destroy
      @template = ImageManagement::Template.find(params[:id]) unless defined? @template
      @template.destroy
      respond_with @template
    end

    private
    def template_params
      params[:template][:xml] = request.body.read
    end
  end
end
