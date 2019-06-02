# frozen_string_literal: true

TRANSLATOR_CLIENT = Faraday.new(url: Settings.translator.url)
