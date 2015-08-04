require 'rails_helper'

RSpec.describe Thank, type: :model do
  before(:each) do
    @user = create(:uesteibar)
    @user.confirm!
    book = create(:book)
    @recommendation = @user.recommend(book, "I loved it!", 50)
    @alaine = create(:alaine)
  end

  describe 'creation' do
    it 'should create a thank on the given recommendation' do
      @recommendation.thanks.create(user: @alaine)
      expect(@alaine.given_thanks.last.recommendation).to eq @recommendation
      expect(@recommendation.thanks.last.user).to eq @alaine
    end

    it 'should raise an error when a user tries to thank his own recommendation' do
      expect do
        @recommendation.thanks.create!(user: @user)
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'should increase the reputation of the user that did the recommendation' do
        @recommendation.thanks.create!(user: @alaine)
        expect(@user.reputation).to eq 1
    end
  end
end
