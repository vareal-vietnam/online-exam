class Test < ApplicationRecord
  CATEGORY_TYPE = %i[git rails].freeze

  acts_as_paranoid

  enum kind: CATEGORY_TYPE

  has_many :results
  has_many :questions

  validates :name, :kind, presence: true
  validates :time, presence: true, numericality: { only_integer: true }
end
