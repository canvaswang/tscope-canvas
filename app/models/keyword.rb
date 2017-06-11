class Keyword < ActiveRecord::Base
  has_many :tweets

  def grab_twitts
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "bCMpQkBX7l8UcRaGgC7I3i64G"
      config.consumer_secret     = "aLpkA2y9spelZG2l4sYsRoMihjccklKvf2YTq0zNDifsN7OXhu"
      config.access_token        = "3832722974-bJkQLUatYDFnWoKDHjFyyzO1m8YKW9npyn2X6KW"
      config.access_token_secret = "3RZoADuhzIVcPvsy90bNs6cLLoE3iXgHBOXwxRoLyBitS"
    end

    client.search(self.word, result_type: "recent").take(10).collect do |tweet|
      new_tweet = Tweet.new
      new_tweet.tweet_id = tweet.id.to_s
      new_tweet.tweet_created_at = tweet.created_at
      new_tweet.text = tweet.text

      new_tweet.user_uid = tweet.user.id
      new_tweet.user_name = tweet.user.name
      new_tweet.user_screen_name = tweet.user.screen_name
      new_tweet.user_image_url = tweet.user.profile_image_url

      new_tweet.keyword = self

      new_tweet.save
    end
  end
end
