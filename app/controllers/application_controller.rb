class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def render_401
    render file: "#{Rails.root}/public/401.html", layout: false, status: 401
  end
end
