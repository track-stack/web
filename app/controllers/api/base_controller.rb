module Api
  class BaseController < ::ActionController::Base
    def whereisthis
      puts "here"
    end

    def require_application!
      raise "hell" unless current_application
    end

    def current_application
      @current_application ||= Doorkeeper::Application.find_by(uid: params[:app_id])
    end
  end
end
