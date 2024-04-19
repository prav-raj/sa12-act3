require 'httparty'
require 'json'

api_key = 'bc8594890671ba66d493dbd740230d20'
city_id = '2643743'

url = "http://api.openweathermap.org/data/2.5/forecast?id=#{city_id}&appid=#{api_key}"
response = HTTParty.get(url)

if response.code == 200
    data = JSON.parse(response.body)

    temperature = data['list'][0]['main']['temp']
    to_celcius = temperature - 273
    
    puts "Current temperature in London: #{to_celcius.round(2)}°C"
else
    puts "Cannot access weather data for London"
end

