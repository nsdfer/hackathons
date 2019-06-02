# frozen_string_literal: true

class V0::WebhooksController < ApplicationController
  def sms_incoming
    data = parse_data(accept_params[:body])

    message = translate_message(language: data[:language], message: data[:message])

    TWILIO_CLIENT.api.account.messages.create(
      from: Settings.twilio.phone_number,
      to: data[:to],
      body: message
    )

    head :ok
  rescue StandardError => e
    puts e
    head :unprocessable_entity
  end

  private

  def accept_params
    params.permit(:Body, :From, :To).transform_keys(&:downcase)
  end

  def parse_data(content)
    data = content.split("\n")
    meta = data[0].split(';')
    message = data.slice(1, data.size).join(' ')

    { to: meta[0], language: meta[1], message: message }
  end

  def translate_message(language:, message:)
    response = TRANSLATOR_CLIENT.post do |req|
      req.url '/translate'
      req.headers['Content-Type'] = 'application/json;charset=UTF-8'
      req.body = { dest: language, message: message }.to_json
    end

    response.body
  end
end
