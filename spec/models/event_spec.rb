require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'creation' do
    before(:each) do
      @uesteibar = create(:uesteibar)
      @uesteibar.confirm!
      @alaine = create(:alaine)
      @alaine.confirm!
      @alaine.follow(@uesteibar)

      @book = create(:book)
    end

    context 'when recommending a book' do
      it 'should create an event on every follower' do
        expect do
          @uesteibar.recommend(@book, 'I loved it!', 50)
        end.to change(@alaine.events, :count).by(1)
      end

      it 'should create an event with the correct URN on every follower' do
        recommendation = @uesteibar.recommend(@book, 'I loved it!', 50)
        expect(@alaine.events.last.item_urn).to eq "recommendation:#{recommendation.id}"
      end
    end

    context 'when offering a book' do
      it 'should create an event on every follower' do
        expect do
          @uesteibar.ownerships.create(book_id: @book.id, to_exchange: true)
        end.to change(@alaine.events, :count).by(1)
      end

      it 'should create an event with the correct URN on every follower' do
        ownership = @uesteibar.ownerships.create(book_id: @book.id, to_exchange: true)
        expect(@alaine.events.last.item_urn).to eq "ownership:#{ownership.id}"
      end
    end
  end
end
