User.create! name: "admin",
  email: "admin@vareal.vn",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true

10.times do |n|
  User.create! name:  Faker::Name.name,
               email: "example#{n+1}@vareal.vn",
               password: "123456",
               password_confirmation: "123456"
end

Test.create! kind: :git, time: 600, name: "Git Test Basic"
Test.create! kind: :rails, time: 600, name: "Ruby Test"
Test.create! kind: :git, time: 600, name: "Rails Test"
Test.create! kind: :rails, time: 600, name: "Git Test Advance"

20.times do |n|
  Result.create! score: rand(1..10),
    user: User.all.sample,
    test: Test.all.sample
end

10.times do |n|
  question = Question.create! content: Faker::Lorem.question, test: Test.first
  Answer.create! content: Faker::Lorem.sentence, question: question, is_correct: true

  3.times do |m|
    Answer.create! content: Faker::Lorem.sentence, question: question, is_correct: false
  end
end
