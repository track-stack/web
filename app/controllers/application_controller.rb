class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def render_401
    render file: "#{Rails.root}/public/401.html", layout: false, status: 401
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      hand = ["✋🏻", "✋🏼", "✋🏽", "✋🏾", "✋🏿"].sample
      flash[:error] = "#{hand} You need to log in to see that"
      redirect_to :root
    end
  end
end
