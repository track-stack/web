class Api::V1::DevicesController < ::Api::BaseController
  before_action :doorkeeper_authorize!

  def register
    current_user.register_device(
      expo_token: params[:expo_token],
      device_id: params[:device_id]
    )

    head :ok
  end
end
