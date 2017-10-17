module FacebookApiHelper
  def fb_api_json(endpoint)
    case endpoint
    when :friends
      file = file_fixture("facebook_friends_fetch.json").read
      JSON.parse(file)
    else
      raise "invalid endpoint"
    end
  end
end
