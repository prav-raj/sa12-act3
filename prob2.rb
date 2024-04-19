require 'httparty'
require 'json'

def fetch_exchange_rate(source_currency, target_currency, api_key)
  url = "https://v6.exchangerate-api.com/v6/#{api_key}/pair/#{source_currency}/#{target_currency}"
  response = HTTParty.get(url)

  if response.code == 200
    data = JSON.parse(response.body)
    if data['result'] == 'success'
      return data['conversion_rate']
    else
      puts "Error fetching exchange rate: #{data['error-type']}"
      nil
    end
  else
    puts "HTTP Request failed with code #{response.code}"
    nil
  end
end

def convert_currency(amount, source_currency, target_currency, api_key)
  rate = fetch_exchange_rate(source_currency, target_currency, api_key)
  if rate
    converted_amount = amount * rate
    puts "#{amount} #{source_currency} converts to #{converted_amount.round(2)} #{target_currency} at a rate of #{rate}"
  else
    puts "Failed to convert currency due to API error."
  end
end

api_key = '699b1e630e9fb7faa6db4484'
source_currency = 'USD' 
target_currency = 'EUR'
amount = 100

convert_currency(amount, source_currency, target_currency, api_key)
