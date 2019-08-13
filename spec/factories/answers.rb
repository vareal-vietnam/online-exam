FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.sentence }
    is_correct { false }
    question

    trait :is_true do
      is_correct { true }
    end
  end
end
