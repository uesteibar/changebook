require 'rails_helper'

RSpec.describe ThanksController, type: :controller do
  before(:each) do
    @user = create(:uesteibar)
    @user.confirm!
    book = create(:book)
    @recommendation = @user.recommend(book, "I loved it!", 50)
    @alaine = create(:alaine)
    @alaine.confirm!
    sign_in @alaine
  end

  describe '#create' do
    it 'should create a thanks in the given recommendation' do
      expect do
        post :create, id: @recommendation.id
      end.to change(@recommendation.thanks, :count).by(1)
    end
  end
end
