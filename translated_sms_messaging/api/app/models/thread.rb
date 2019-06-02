# frozen_string_literal: true

class Channel < ApplicationRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :channel

  field :from_language, type: Integer
  field :to_language, type: Integer
  field :to_phone_number, type: Integer
  field :from_phone_number, type: Integer
end
