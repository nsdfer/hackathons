# frozen_string_literal: true

class User < ApplicationRecord
  include Mongoid::Document
  extend Enumerize

  field :status, type: String
  enumerize :status,
            in: %i[active inactive unverified],
            default: :unverified,
            predicates: true

  field :first_name, type: String
  field :last_name, type: String
  field :language, type: String
  field :phone_number, type: String
  field :verification_code, type: String

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :language, presence: true
  validates :phone_number, presence: true
end
