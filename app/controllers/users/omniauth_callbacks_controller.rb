class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    redirect_to "/"
  end
end
