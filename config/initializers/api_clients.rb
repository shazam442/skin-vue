# config/initializers/api_clients.rb
#
# frozen_string_literal: true

# Load the Skinbaron API client

# SkinbaronClient is a constant that holds the initialized API client instance
# We use a constant here since we want this client to be available globally
# throughout the application's lifecycle
SkinbaronClient = SkinbaronApiClient::Client.new do |config|
  config.api_key = ENV["SKINBARON_API_KEY"]
  config.debug = true
  config.log_path = "log/skinbaron/"
end
