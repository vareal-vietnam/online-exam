FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.sentence }
    is_correct { false }
    question

    trait :correct_answer do
      is_correct { true }
    end
  end
end
