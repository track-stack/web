require "faraday"

module Facebook
  module FriendFinder
    def all_friends_for(user:)
      find_friends(user)
    end

    private

    def find_friends(user)
      users = []

      find_friends = lambda do |url|
        response = Faraday.get url
        json = JSON.parse(response.body)

        users << json["data"]

        find_friends.call(json["paging"]["next"]) if json["paging"] && json["paging"]["next"]
      end

      first_page_url = fetch_friends_url(user)
      find_friends.call(first_page_url)

      users.flatten
    end

    def app_id
      ENV["FACEBOOK_APP_ID"]
    end

    def app_access_token
      ENV["FACEBOOK_APP_ACCESS_TOKEN"]
    end

    def fetch_friends_url(user)
      "https://graph.facebook.com/v2.10/#{user.uid}/friends?fields=id,name,picture{url}&access_token=#{user.oauth_token}"
    end
  end
end
