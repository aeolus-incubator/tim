module ImageManagement
  class ApplicationController < ActionController::Base
    protect_from_forgery

    # FIXME Remove filter once support for custom XML with nested resources is
    # supported by rails.
    before_filter UserKeysFilter, :only => [:create, :update]

    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

    def render_not_found
      render :nothing => true, :status => :not_found
    end
  end
end