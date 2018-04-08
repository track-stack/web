module Api
  class BaseController < ::ActionController::Base
    def require_application!
      return render file: "public/401.html", status: :unauthorized unless current_application
    end

    def current_application
      @current_application ||= Doorkeeper::Application.find_by(uid: params[:app_id])
    end

    def current_user
      return unless doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end

    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

    def render_401
      render file: "#{Rails.root}/public/401.html", layout: false, status: 401
    end
  end
end
