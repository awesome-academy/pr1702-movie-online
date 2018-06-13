10.times do |n|
  User.create(
    email: "user#{n+1}@gmail.com",
    name: "User#{n+1}",
    password: "123456",
    confirmed_at: Time.now,
    confirmation_token: nil)
end

User.create(
    email: "user12@gmail.com",
    name: "User12",
    password: "123456",
    confirmed_at: Time.now,
    confirmation_token: nil,
    role: 1,
)
