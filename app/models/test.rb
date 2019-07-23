class Test < ApplicationRecord
  CATEGORY_TYPE = [:git, :rails]

  enum kind: CATEGORY_TYPE

  has_many :result

  validates :name, :kind, presence: true
  validates :time, presence: true, numericality: { only_integer: true }
end
