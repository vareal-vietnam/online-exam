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

Question.create! content: "Question A", test_id: 1
Question.create! content: "Question B", test_id: 2
Question.create! content: "Question C", test_id: 3
Question.create! content: "Question D", test_id: 4
Question.create! content: "Question E", test_id: 1
Question.create! content: "Question F", test_id: 2
Question.create! content: "Question G", test_id: 1

create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.string "content"
  t.integer "test_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["test_id"], name: "index_questions_on_test_id"
end
