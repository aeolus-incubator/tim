module ImageManagement
  class TemplatesController < ApplicationController
    # GET /templates
    # GET /templates.xml
    def index
      @templates = ImageManagement::Template.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml # index.xml
      end
    end

    # GET /templates/1
    # GET /templates/1.xml
    def show
      @template = ImageManagement::Template.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml # show.xml
      end
    end

    # GET /templates/new
    # GET /templates/new.xml
    def new
      @template = ImageManagement::Template.new

      respond_to do |format|
        format.html # new.html.erb
      end
    end

    # GET /templates/1/edit
    def edit
      @template = ImageManagement::Template.find(params[:id])
    end

    # POST /templates
    # POST /templates.xml
    def create
      respond_to do |format|
        begin
        # TODO Validate template
          params[:template][:xml] = request.body.read
          @template = ImageManagement::Template.new(params[:template])

          if @template.save
            format.html { redirect_to @template, :notice => 'Template was successfully created.' }
            format.xml { render :action => "show", :status => :created }
          else
            format.html { render :action => "new" }
            format.xml { render :xml => @template.errors, :status => :unprocessable_entity }
          end
          # TODO Add in proper exception handling in application controller
        rescue => e
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /templates/1
    # PUT /templates/1.xml
    def update
      respond_to do |format|
        begin
          params[:template][:xml] = request.body.read
          @template = ImageManagement::Template.find(params[:id])

          if @template.update_attributes(params[:template])
            format.html { redirect_to @template, :notice => 'Template was successfully updated.' }
            format.xml { head :no_content }
          else
            format.html { render :action => "edit" }
            format.xml { render :xml => @template.errors, :status => :unprocessable_entity }
          end
          # TODO Add in proper exception handling in appliation controller
        rescue => e
          format.html { render :action => "new" }
          format.xml { render :xml => e.message, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /templates/1
    # DELETE /templates/1.xml
    def destroy
      @template = ImageManagement::Template.find(params[:id])
      @template.destroy

      respond_to do |format|
        format.html { redirect_to image_management_templates_url }
        format.xml { head :no_content }
      end
    end
  end
end
