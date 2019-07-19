User.create! name: "admin",
  email: "admin@vareal.vn",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true

100.times do |n|
  User.create! name: Faker::Name.name,
    email: "user#{n + 1}@vareal.vn",
    password: "123456",
    password_confirmation: "123456"
end
