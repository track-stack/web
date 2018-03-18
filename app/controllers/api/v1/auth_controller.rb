module Api
  module V1
    class AuthController < ::Api::BaseController
      before_action only: [:create] do
        require_application!
      end

      def create
        profile = fetch_profile
        auth = generate_auth_hash(profile)

        if user = User.from_omniauth(auth)
          token = user.generate_access_token(current_application.id)
          render json: {
            user: UserSerializer.new(user),
            access_token: token.token
          }
        else
          render json: { error: user.errors.full_messages.to_sentence }
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
          uid: profile[:id],
          provider: "facebook",
          credentials: {
            token: params[:token] ,
            expires_at: Time.at(params[:expires].to_i)
          },
          info: {
            email: profile[:email],
            name: [profile[:first_name], profile[:last_name]].compact.join(" "),
            image: profile[:picture][:data][:url]
          }
        })
      end
    end
  end
end
