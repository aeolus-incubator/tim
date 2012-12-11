module Tim
  class ApplicationController < ::ApplicationController
    protect_from_forgery

    respond_to :html, :xml

    append_before_filter :set_default_respond_options

    # FIXME Remove filter once support for custom XML with nested resources is
    # supported by rails.
    before_filter UserKeysFilter, :only => [:create, :update]

    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

    def render_not_found
      render :nothing => true, :status => :not_found
    end

    private
    def set_default_respond_options
      @respond_options = { :responder => CustomResponder } unless defined? @respond_options
    end
  end
end
