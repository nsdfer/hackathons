# frozen_string_literal: true

class Settings
  extend Mixlib::Config

  require 'dotenv/load' if ENV['RAILS_ENV'] == 'development'

  config_context :mongoid do
    default(:uri, ENV['MONGO_URL'])
  end

  config_context :twilio do
    default(:account_sid, ENV['TWILIO_ACCOUNT_SID'])
    default(:auth_token, ENV['TWILIO_AUTH_TOKEN'])
    default(:phone_number, ENV['TWILIO_PHONE_NUMBER'])
  end
end
