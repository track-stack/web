class FriendsController < ApplicationController
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
