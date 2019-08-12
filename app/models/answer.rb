class Answer < ApplicationRecord
  acts_as_paranoid

  before_save :trim_space

  belongs_to :question
  has_many :result_answers, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
  validates :question, presence: true

  private

  def trim_space
    self.content = content.squish
  end
end
