# frozen_string_literal: true

class Party < ApplicationRecord
  has_many :party_users
  has_many :users, through: :party_users

  validates :date , presence: true
  validates :time , presence: true
  validates :duration , numericality: { only_integer: true }
end
