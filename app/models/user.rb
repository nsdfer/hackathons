# frozen_string_literal: true

class User < ApplicationRecord
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :language, type: String
  field :phone_number, type: Integer

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :language, presence: true
  validates :phone_number, presence: true
end
