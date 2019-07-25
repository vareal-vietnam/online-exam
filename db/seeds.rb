10.times do |n|
  User.create! name: Faker::Name.name, email: "user#{n+1}@vareal.vn", password: "123456", password_confirmation: "123456"
end

10.times do
  Test.create! kind: [:git, :rails].sample, time: [500, 600, 400].sample, name: ["Git advance", "Git basic", "Rails basic", "Rails advance"].sample
end

30.times do
  Result.create! score: rand(1..10), user: User.all.sample, test: Test.all.sample
end

60.times do
  question = Question.create! content: Faker::Lorem.question, test: Test.all.sample

  Answer.create! content: Faker::Lorem.sentence, is_correct: true, question: question
  3.times do
    Answer.create! content: Faker::Lorem.sentence, question: question
  end
end
