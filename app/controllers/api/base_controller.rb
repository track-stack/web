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

    def current_user
      return unless doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end
end
