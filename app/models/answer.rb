class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :question, presence: true
end
