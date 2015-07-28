FactoryGirl.define do
  factory :book do
    title "The Lord Of The Rings"
    author "J.R.R. Tolkien"
    image_url "http://cdn3.vox-cdn.com/assets/4242181/lord_of_the_rings_book_cover_by_mrstingyjr-d5vwgct.jpg"
    to_give_away true
    to_exchange false
    user
  end

end
