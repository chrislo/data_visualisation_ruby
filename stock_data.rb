require 'rubygems'
require 'yahoofinance'
require 'time'

class StockData
  def self.for(symbol, days)
    data = YahooFinance::get_historical_quotes_days(symbol, days)
    return_data = []
    data.each {|d| return_data << [d[0], d[4].to_f]}
    return_data
  end
  
  def self.csv_for(symbol, days)
    data = self.for(symbol, days)
    csv = ""
    data.each do |d|
      date = Time.parse(d[0]).strftime('%Y-%m-%d %H:%M:%S')
      close = d[1]
  
      csv << "#{date},#{close}\n"
    end
    csv
  end
end

# puts StockData.for('RBS.L', 365)


