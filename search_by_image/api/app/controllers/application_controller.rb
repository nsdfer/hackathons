# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_not_found

  def render_not_found(_exception)
    head :not_found
  end
end
