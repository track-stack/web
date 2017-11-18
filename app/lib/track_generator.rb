require 'faraday'

module TrackGenerator
  GENRES = ["jazz", "blues", "pop", "rap", "folk", "reggae", 
    "funk", "rock", "disco"].freeze
  
  def generate_track
    genre = GENRES.sample
    url = "http://ws.audioscrobbler.com/2.0/?method=tag.gettoptracks&tag=#{genre}&api_key=#{key}&format=json"

    response = Faraday.get(url)
    JSON.parse(response.body)["tracks"]["track"].sample
  end

  private

  def key
    ENV["LASTFM_API_KEY"]
  end
end
