class Answer < ApplicationRecord
  acts_as_paranoid

  belongs_to :question

  validates :content
  validates :question
end
