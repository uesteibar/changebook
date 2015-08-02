require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar

    @book = create(:book)

    @comment = "I loved it!"
  end

  after(:each) do
    Book.destroy_all
    Ownership.destroy_all
  end

  describe 'create a recommendation' do
    it 'should create a rommendation when all params are given' do
      expect do
        post :create, book_id: @book.id, recommendation: {comment: @comment}
      end.to change(Recommendation, :count).by(1)
    end

    it 'should NOT create a rommendation when comment is missing' do
      expect do
        post :create, book_id: @book.id, recommendation: {comment: ""}
      end.to change(Recommendation, :count).by(0)
    end
  end
end
