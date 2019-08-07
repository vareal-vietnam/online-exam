class Result < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :test

  has_many :result_answers

  validate :user
  validate :test
end
