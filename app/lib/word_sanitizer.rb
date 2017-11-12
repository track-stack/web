module WordSanitizer
  BLACKLIST = "a|an|and|the|in"

  # Public: Returns a transformed string
  #
  # result - the string to transform
  #
  # Returns String
  def sanitize_result(result)
    result = result.downcase

    # many times, featured results, or additional producers are appended
    # to the result like so: (featuring beep and boop...)
    result = result.gsub(/[\(\)\[\]]/, "")

    # remove all . and ' and replace them with ""
    result = result.gsub(/[.']/, "")

    # remove all - or _ and replace them with " "
    result = result.gsub(/[-_]/, " ")

    # remove all blacklisted articles
    result = result.gsub(/\b(#{BLACKLIST})\b/, "")

    # replace multiple spaces with a single space
    result = result.gsub(/\s+/, " ").strip
  end
end
