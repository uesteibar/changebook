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

    it 'should create an event on every follower when a user recommends a book' do
      expect do
        @uesteibar.recommend(@book, "I loved it!")
      end.to change(@alaine.events, :count).by(1)
    end

    it 'should create an event with the correct URN on every follower when a user recommends a book' do
      recommendation = @uesteibar.recommend(@book, "I loved it!")
      expect(@alaine.events.last.item_urn).to eq "recommendation:#{recommendation.id}"
    end
  end
end
