# frozen_string_literal: true

class V0::WebhooksController < ApplicationController
  def sms_incoming
    puts params
    puts headers

    head :ok
  end

  private

  def accept_params
    # {
    #   "Body"=>"Hello Tony!",
    #   "From"=>"+14086232254",
    #   "To"=>"+14087062472",
    # }
  end
end
