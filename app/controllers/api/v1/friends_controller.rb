class Api::V1::FriendsController < ::Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :require_application!

  include ::Facebook::FriendFinder

  def list
    if current_user
      friends = all_friends_for(user: current_user)
      render json: { friends: friends }
    else
      render_401
    end
  end
end
