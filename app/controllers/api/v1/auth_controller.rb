class Api::V1::AuthController < ::Api::ApiController
  def create
    puts "*" * 80
    puts params[:token]
    puts "*" * 80
    head :ok
  end
end