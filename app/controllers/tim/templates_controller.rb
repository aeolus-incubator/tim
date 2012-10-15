module Tim
  class TemplatesController < Tim::ApplicationController

    def index
      @templates = Tim::Template.all unless defined? @templates
      respond_with @templates
    end

    def show
      @template = Tim::Template.find(params[:id]) unless defined? @template
      respond_with @template
    end

    def new
      @template = Tim::Template.new unless defined? @template
      respond_with @template
    end

    def edit
      @template = Tim::Template.find(params[:id])
      respond_with @template
    end

    def create
      @template = Tim::Template.new(params[:template]) unless defined? @template
      if @template.save
        flash[:notice] = 'Template was successfully created.'
      end
      respond_with @template
    end

    def update
      @template = Tim::Template.find(params[:id]) unless defined? @template
      if @template.update_attributes(params[:template])
        flash[:notice] = 'Template was successfully updated.'
      end
      respond_with @template
    end

    def destroy
      @template = Tim::Template.find(params[:id]) unless defined? @template
      @template.destroy
      respond_with @template
    end

  end
end
