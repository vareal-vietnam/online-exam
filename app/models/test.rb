class Test < ApplicationRecord
  CATEGORY_TYPE = [:git, :rails]

  enum kind: CATEGORY_TYPE

  has_many :results
  has_many :questions
  validates :time, :name, :kind, presence: true
end
