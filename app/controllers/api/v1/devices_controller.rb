class Api::V1::DevicesController < ::Api::BaseController
  before_action :doorkeeper_authorize!

  def register
    current_user.register_device(params[:apns_token])
    head :ok
  end
end
