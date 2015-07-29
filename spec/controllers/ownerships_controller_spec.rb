require 'rails_helper'

RSpec.describe OwnershipsController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar

    @book = create(:book)
  end

  describe 'create a ownership' do
    it 'should create a ownership' do
      expect do
        post :create, ownership: {book_id: @book.id, to_give_away: true}
      end.to change(Ownership, :count).by(1)
    end

    it 'should NOT create a rommendation when book_id is missing' do
      expect do
        post :create, ownership: {book_id: nil, to_give_away: true}
      end.to change(Ownership, :count).by(0)
    end
  end
end
