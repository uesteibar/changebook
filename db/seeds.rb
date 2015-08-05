uesteibar = User.create(
  username: "uesteibar",
  email: "uesteibar@gmail.com",
  password: "uesteibar",
  bio: "Yey! Here I am!",
  latitude: 43,
  longitude: 2
)
uesteibar.confirm

def create_fake_user
  username = Faker::Internet.user_name
  user = User.create(
    username: username,
    email: Faker::Internet.safe_email(username),
    password: Faker::Internet.password,
    bio: Faker::Hacker.say_something_smart,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
  )
  user.confirm
end

100.times do
  create_fake_user
end

800.times do
  follower = User.all.sample
  followed = User.all.sample
  unless follower.id == followed.id || follower.following?(followed)
    follower.follow(followed)
  end
end

genres = [
  "Fantasy",
  "Science Fiction",
  "Software Development",
  "Thriller",
  "Bellic",
  "Romantic",
  "History",
  "Novel",
  "Languages"
]

genres.each do |genre|
  Genre.create(name: genre)
end
