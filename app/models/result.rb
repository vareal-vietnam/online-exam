class Result < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :test

  validates :score, presence: true
  validates :user, presence: true
  validates :test, presence: true
end
