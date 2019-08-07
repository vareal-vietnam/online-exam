class ResultAnswer < ApplicationRecord
  scope :search, -> (answer){where answer: answer}
  scope :search_re, -> (result){where result: result}
  belongs_to :answer
  belongs_to :result
end
