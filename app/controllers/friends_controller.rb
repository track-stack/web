require "faraday"

class FriendsController < ApplicationController
  include ::Facebook::FriendFinder

  def list
    if current_user
      friends = all_friends_for(user: current_user)
      render json: { friends: friends }
    else
      render file: "#{Rails.root}/public/401", layout: false, status: 401, formats: [:html]
    end
  end
end
