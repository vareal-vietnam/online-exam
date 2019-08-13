FactoryBot.define do
  factory :test do
    trait :kind_git do
      kind { 'git' }
    end

    trait :kind_rails do
      kind { 'rails' }
    end
    name { Faker::Name.name }
    time { Random.new.rand(1..10_000) }
  end
end
