FactoryBot.define do
  factory :test do
    name { Faker::Name.name }
    time { Random.new.rand(1..10_000) }
    kind { 'rails' }

    trait :kind_git do
      kind { 'git' }
    end
  end
end
