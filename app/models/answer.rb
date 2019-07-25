class Answer < ApplicationRecord
  acts_as_paranoid

  belongs_to :question

  validates :content, presence: true
  validates :question, presence: true
end
