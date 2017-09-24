class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if user = User.from_omniauth(auth_hash)
      sign_in_and_redirect user, event: :authentication
    else
      session["devise.facebook_data"] = auth_hash
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

private

  def auth_hash
    request.env["omniauth.auth"]
  end

end
