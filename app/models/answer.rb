class Answer < ApplicationRecord
  include ModuleTrimSpace

  acts_as_paranoid

  before_save :trim_space_content

  belongs_to :question
  has_many :result_answers, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
  validates :question, presence: true
end
