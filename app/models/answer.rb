class Answer < ApplicationRecord
  acts_as_paranoid

  belongs_to :question
  has_many :result_answers, dependent: :destroy

  validates :content, presence: true
  validates :question, presence: true
end
