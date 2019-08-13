FactoryBot.define do
  factory :question do
    content { Faker::Lorem.question }
    association :test, :kind_git
  end
end
