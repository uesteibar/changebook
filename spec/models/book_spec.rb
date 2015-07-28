require 'rails_helper'

RSpec.describe Book, type: :model do
  before(:each) do
    @user = create(:uesteibar)
    @book_params = {
      title: "The Lord Of The Rings",
      author: "J.R.R. Tolkien"
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
