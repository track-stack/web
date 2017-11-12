require 'spec_helper'

RSpec.describe WordSanitizer do
  include WordSanitizer

  context "#sanitize_result" do
    it "strips parentheses" do 
      name_and_artist = "song name by artist (featuring other artists)"
      result = sanitize_result(name_and_artist)
      expect(result).to eq("song name by artist featuring other artists")
    end

    it "strips brackets" do
      name_and_artist = "song name by artist [featuring other artists]"
      result = sanitize_result(name_and_artist)
      expect(result).to eq("song name by artist featuring other artists")
    end

    it "strips - and _" do
      str = "this_word-that_word_whoa-baby"
      result = sanitize_result(str)
      expect(result).to eq("this word that word whoa baby")
    end

    it "strips blacklisted articles" do
      string_with_articles = "The something in the way and she the moves A"
      result = sanitize_result(string_with_articles)
      expect(result).to eq("something way she moves")
    end
  end
end
