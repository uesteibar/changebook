require 'rails_helper'

RSpec.describe Book, type: :model do
  before(:each) do
    @user = create(:uesteibar)
    @book_params = {
      title: "The Lord Of The Rings",
      synopsis: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      author: "J.R.R. Tolkien",
      date: 20.years.ago,
      image_url: "http://cdn3.vox-cdn.com/assets/4242181/lord_of_the_rings_book_cover_by_mrstingyjr-d5vwgct.jpg",
      to_give_away: true,
      to_exchange: false
    }
  end

  describe 'create' do
    it 'should create a book assigned to a user when all params are given' do
      @user.books.create(@book_params)
      expect(@user.books.last.title).to eq @book_params[:title]
      expect(@user.books.last.id).not_to be_falsy
    end
  end
end
