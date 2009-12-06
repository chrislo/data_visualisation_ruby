require 'rubygems'
require 'grackle'

# Use Grackle to get a timeline of tweets from an individual user
client = Grackle::Client.new

1.upto(20) do |page|
  tweets =
    client.statuses.user_timeline?(:screen_name=>'chrislowis',
                                   :page => page)
end
