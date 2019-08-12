class Question < ApplicationRecord
  acts_as_paranoid

  before_save :trim_space

  belongs_to :test
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
                                reject_if: :all_blank, allow_destroy: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :test, presence: true

  private

  def trim_space
    self.content = content.squish
  end
end
