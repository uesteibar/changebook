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

  after(:each) do
    Book.destroy_all
    Ownership.destroy_all
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

  describe 'PUT #accept' do
    before(:each) do
      @alaine.request_transfer(@uesteibar.ownerships.last)
    end
    context 'when the user is logged in' do
      it 'mark a transfer request as read' do
        put :accept, id: @uesteibar.received_transfers.last.id

        expect(@alaine.books.last).to eq @book
        expect(@uesteibar.received_transfers.size).to eq 0
        expect(@uesteibar.books.size).to eq 0
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @uesteibar
      end

      it 'redirects to root' do
        put :accept, id: @uesteibar.received_transfers.last.id
        expect(response).to redirect_to('/login')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @alaine.request_transfer(@uesteibar.ownerships.last)
    end
    context 'when the user is logged in' do
      it 'destroy a transfer request' do
        expect do
          delete :destroy, id: @uesteibar.received_transfers.last.id
        end.to change(Transfer, :count).by(-1)
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @uesteibar
      end

      it 'redirects to root' do
        delete :destroy, id: @uesteibar.received_transfers.last.id
        expect(response).to redirect_to('/login')
      end
    end
  end
end
