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

Relationship.create(requesting_id: User.first.id, requested_id: User.second.id, status:"accepted")

Relationship.create(requesting_id: User.first.id, requested_id: User.third.id, status:"requested")

Relationship.create(requesting_id: User.fifth.id, requested_id: User.first.id, status:"requested")

Relationship.create(requesting_id: User.fourth.id, requested_id: User.first.id, status:"requested")

User.all.each do |user|
  num_film = rand(1..100)
  Film.all.sample(num_film).each do |film|
    user.comments.create(film: film, content: "abc")
  end
end
