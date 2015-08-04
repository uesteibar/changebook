require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar
  end

  describe 'GET #index' do
    context 'when the user is logged in' do
      it 'responds successfully with an HTTP 200 status code' do
        get :index
        expect(response).to be_success
        expect(response.code.to_i).to eq(200)
      end

      it 'renders the search template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @uesteibar
      end

      it 'redirects to login' do
        get :index
        expect(response).to redirect_to('/login')
      end
    end
  end

  describe 'PUT #mark_read' do
    before(:each) do
      @alaine = create(:alaine)
      @alaine.confirm!

      @book = create(:book)
      @uesteibar.ownerships.create(book_id: @book.id, to_give_away: true)
      @alaine.request_transfer(@uesteibar.ownerships.last)
      @uesteibar.reject_transfer_request(@uesteibar.received_transfers.last)

      sign_out @uesteibar
      sign_in @alaine
    end

    context 'when the user is logged in' do
      it 'create a new notification when a transfer request is rejected' do
        expect do
          post :mark_read, id: @alaine.unread_notifications.last.id
        end.to change(@alaine.unread_notifications, :count).by(-1)
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @alaine
      end

      it 'redirects to root' do
        post :mark_read, id: @alaine.unread_notifications.last.id
        expect(response).to redirect_to('/login')
      end
    end
  end
end
