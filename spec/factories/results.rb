FactoryBot.define do
  factory :result do
    score { Random.new.rand(1..10) }
    user
    association :test, :kind_git
  end
end
