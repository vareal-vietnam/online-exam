class Result < ApplicationRecord
  belongs_to :user
  belongs_to :test

  validates :result, presence: true
  validates :user, presence: true
  validates :test, presence: true
end
