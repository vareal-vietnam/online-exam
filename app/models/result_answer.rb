class ResultAnswer < ApplicationRecord
  belongs_to :answer, optional: true
  belongs_to :result, optional: true
end
