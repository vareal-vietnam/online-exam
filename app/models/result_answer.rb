class ResultAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :result

  validates :answer, presence: true
  validates :result, presence: true
end
