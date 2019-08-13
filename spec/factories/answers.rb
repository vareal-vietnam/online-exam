FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.sentence }
    trait :is_true do
      is_correct { true }
    end
    trait :is_false do
      is_correct { false }
    end
    question
  end
end
