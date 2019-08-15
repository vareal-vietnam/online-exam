class Result < ApplicationRecord
  acts_as_paranoid

  default_scope { order(id: :desc) }

  belongs_to :user
  belongs_to :test
  has_many :result_answers, dependent: :destroy

  validates :user, presence: true
  validates :test, presence: true
end
