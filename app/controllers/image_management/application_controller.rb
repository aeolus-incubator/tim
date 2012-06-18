module ImageManagement
  class ApplicationController < ActionController::Base
    protect_from_forgery

    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

    def render_not_found
      render :nothing => true, :status => :not_found
    end
  end
end