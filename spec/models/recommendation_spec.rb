require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  before(:each) do
    @user = create(:uesteibar)
    @user.confirm!
    @book = create(:book)
    @comment = "I loved it!"
  end

  describe 'create' do
    it 'should create a recommendation when all params are given' do
      @user.recommend(@book, @comment)
      expect(@user.recommendations.last.book).to eq @book
      expect(@user.recommendations.last.comment).to eq @comment
    end
  end
end
