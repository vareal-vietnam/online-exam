class Result < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :test

  has_many :result_answers

  validates :user, presence: true
  validates :test, presence: true
end
