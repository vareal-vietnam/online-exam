class Question < ApplicationRecord
  acts_as_paranoid

  belongs_to :test

  has_many :answers

  validates :test, presence: true
end
