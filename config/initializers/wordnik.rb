Wordnik.configure do |config|
  config.api_key = ENV["WORDNIK_API_KEY"]
  config.username = ENV["WORDNIK_USERNAME"]
  config.password = ENV["WORDNIK_PASSWORD"]
  config.response_format = 'json'
  config.logger = Rails.logger
end