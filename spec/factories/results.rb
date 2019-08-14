FactoryBot.define do
  factory :result do
    score { Random.new.rand(1..10) }
    user
    test
  end
end
