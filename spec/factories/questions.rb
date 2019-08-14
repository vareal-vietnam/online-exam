FactoryBot.define do
  factory :question do
    content { Faker::Lorem.question }
    test
  end
end
