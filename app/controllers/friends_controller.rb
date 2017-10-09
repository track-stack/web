require "faraday"

class FriendsController < ApplicationController
  before_action :authenticate_user!

  def list
    friends = ::Facebook::FriendFinder.all_for(user: current_user)
    render json: { friends: friends }
  end
end
