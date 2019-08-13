class Question < ApplicationRecord
  include ModuleTrimSpaceContent

  acts_as_paranoid

  belongs_to :test
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
                                reject_if: :all_blank, allow_destroy: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :test, presence: true
end
