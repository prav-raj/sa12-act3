require 'httparty'
require 'json'

api_key = 'iqub1Oa5E5mNGxCXeMX2kooPVDWJqXS2'

class FindEvent
    def initialize(api_key)
        @api_key = api_key
    end

    def find_events(location)
        response = HTTParty.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{@api_key}&city=#{location}")

        if response.code == 200
            data = JSON.parse(response.body)
            events = data['_embedded']['events']

            events.each do |event|
                name = event['name']
                venue = event['_embedded']['venues'].first['name']
                date = event['dates']['start']['location']
                time = event['dates']['start']['localtime']

                puts "Event: #{name}"
                puts "Venue: #{venue}"
                puts "Date: #{date}"
                puts "Time: #{time}"
            end
        end
    end
end

res = FindEvent.new(api_key)
res.find_events("Nashville")