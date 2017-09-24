Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
    scope: "email", callback_url: ENV['FACEBOOK_CALLBACK_URL'], image_size: "large"
end
