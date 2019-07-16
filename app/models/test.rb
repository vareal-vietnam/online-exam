class Test < ApplicationRecord
  CATEGORY_TYPE = [:git, :rails]

  enum type: CATEGORY_TYPE

  validates :time, :name, :type, presence: true
end
