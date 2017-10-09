require "faraday"

class FriendsController < ApplicationController
  def list
    if current_user
      friends = ::Facebook::FriendFinder.all_for(user: current_user)
      render json: { friends: friends }
    else
      render file: "#{Rails.root}/public/401", layout: false, status: 401, formats: [:html]
    end
  end
end
