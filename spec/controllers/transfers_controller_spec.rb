require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar

    @alaine = create(:alaine)
    @alaine.confirm!

    @book = create(:book)
    @uesteibar.ownerships.create(book_id: @book.id, to_give_away: true)
  end

  describe 'POST #create' do
    context 'when the user is logged in' do
      it 'create a new transfer request' do
        expect do
          post :create, ownership_id: @uesteibar.ownerships.last.id
        end.to change(@uesteibar.received_transfers, :count).by(1)
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @uesteibar
      end

      it 'redirects to root' do
        post :create, ownership_id: @uesteibar.ownerships.last.id
        expect(response).to redirect_to('/login')
      end
    end
  end
end
