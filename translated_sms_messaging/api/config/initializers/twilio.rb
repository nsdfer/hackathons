# frozen_string_literal: true

TWILIO_CLIENT = Twilio::REST::Client.new(
  Settings.twilio.account_sid,
  Settings.twilio.auth_token
)
