User.create! name: "Admin",
  email: "admin@vareal.vn",
  is_admin: "true",
  password: "123456",
  password_confirmation: "123456",
  activated: true,
  activated_at: Time.zone.now


10.times do |n|
  User.create! name: Faker::Name.name,
    email: "user#{n+1}@vareal.vn",
    password: "123456",
    password_confirmation: "123456",
    activated: true,
    activated_at: Time.zone.now
end

Test.create! kind: :git, time: 600, name: "Git advance"
Test.create! kind: :git, time: 500, name: "Git basic"
Test.create! kind: :rails, time: 400, name: "Rails basic"
Test.create! kind: :rails, time: 700, name: "Rails advance"

result =   Result.create! score: rand(1..10),
    user: User.all.sample,
    test: Test.first

30.times do
  Result.create! score: rand(1..10),
    user: User.all.sample,
    test: Test.all.sample
end

10.times do |n|
  question = Question.create! content: Faker::Lorem.question, test: Test.first
  answer = Answer.create! content: Faker::Lorem.sentence, question: question, is_correct: true

  3.times do |m|
    Answer.create! content: Faker::Lorem.sentence, question: question, is_correct: false
  end

  ResultAnswer.create! answer: answer, result: result
end
