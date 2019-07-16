class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :is_correct, presence: true
  validates :question, presence: true
end
