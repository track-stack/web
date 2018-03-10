class Api::V1::AuthController < ::Api::ApiController
  def create
    profile = fetch_profile
    auth = generate_auth_hash(profile)

    if user = User.from_omniauth(auth)
      render json: { id: user.id }
    else
      raise "what the fuck"
    end
  end

  private 

  def fetch_profile 
    fields = ["picture.width(480)", "email", "first_name", "last_name"]
    if found = graph.get_object('me', fields: fields)
      found.with_indifferent_access
    end
  end

  def graph
    token = params[:token]
    Koala::Facebook::API.new(token)
  end

  def generate_auth_hash(profile)
    OmniAuth::AuthHash.new({
      uid: profile[:uid],
      provider: "facebook",
      credentials: { 
        token: params[:token] ,
        expires_at: 1.month.from_now, # Time.at(auth.credentials.expires_at)
      },
      info: {
        email: profile[:email],
        name: [profile[:first_name], profile[:last_name]].compact.join(" "),
        image: profile[:picture][:data][:url]
      }
    })
  end
end
