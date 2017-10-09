require 'test_helper'

class FriendsController < ActionController::TestCase
  test "renders 401 for anonymous user" do
    assert_response 401
  end
end

