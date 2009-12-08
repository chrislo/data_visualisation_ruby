require 'base64'
require 'net/http'
require '../stock_data.rb'
require 'yaml'

# You need an API key from timetric.com. I've put mine in a yaml file and
# loaded it from there.
authentication = YAML.load_file(ENV['HOME'] + '/.timetric_api')
key = authentication[:key]
secret = authentication[:secret]
basic_str = "Basic #{Base64.b64encode(key+":"+secret)}"

# Use our simple stock market class to get some time-history data to
# play with.
data = StockData.csv_for('TSCO', 365)

# Make a post request to timetric to upload the time series.
http = Net::HTTP.new('timetric.com')

headers = {
   'Authorization' => basic_str,
   'Content-Type' => 'text/csv'
}
res = http.post('/create/?title=tsco&caption=prices', data, headers)
puts res.body
