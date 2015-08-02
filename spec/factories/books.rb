FactoryGirl.define do
  factory :book do
    title "The Lord Of The Rings"
    author "J.R.R. Tolkien"
    genre Genre.create(name: "Fantasy")
  end

end
