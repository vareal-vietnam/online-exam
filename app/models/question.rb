class Question < ApplicationRecord
  acts_as_paranoid

  belongs_to :test

  has_many :answers

  accepts_nested_attributes_for :answers,
                                reject_if: :all_blank, allow_destroy: true

  validates :test, presence: true
end
