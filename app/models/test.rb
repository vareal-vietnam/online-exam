class Test < ApplicationRecord
  include ModuleTrimSpaceName

  CATEGORY_TYPE = %i[git rails].freeze
  acts_as_paranoid

  attr_accessor :answer_choise

  enum kind: CATEGORY_TYPE

  has_many :results, dependent: :destroy
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions,
                                reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, length: { maximum: 255, minimum: 3 }
  validates :kind, presence: true
  validates :time, presence: true, numericality: { only_integer: true }
end
