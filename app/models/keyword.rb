class Keyword < ActiveRecord::Base
  def grab_twitts
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "bCMpQkBX7l8UcRaGgC7I3i64G"
      config.consumer_secret     = "aLpkA2y9spelZG2l4sYsRoMihjccklKvf2YTq0zNDifsN7OXhu"
      config.access_token        = "3832722974-bJkQLUatYDFnWoKDHjFyyzO1m8YKW9npyn2X6KW"
      config.access_token_secret = "3RZoADuhzIVcPvsy90bNs6cLLoE3iXgHBOXwxRoLyBitS"
    end

    client.search(self.word, result_type: "recent").take(3).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
    end
  end
end
