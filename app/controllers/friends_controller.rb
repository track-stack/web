require "faraday"

class FriendsController < ApplicationController
  def list
    if current_user
      friends = ::Facebook::FriendFinder.all_for(user: current_user)
      render json: { friends: friends }
    end
  end
end
