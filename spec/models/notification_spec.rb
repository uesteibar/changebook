require 'rails_helper'

RSpec.describe Notification, type: :model do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!

    @alaine = create(:alaine)
    @alaine.confirm!

    @book = create(:book)
    @uesteibar.ownerships.create(book_id: @book.id, to_give_away: true)
    @alaine.request_transfer(@uesteibar.ownerships.last)
  end

  describe 'create' do
    it 'should create a notification when a user rejects your transfer request' do
      expect do
        @uesteibar.reject_transfer_request(@uesteibar.received_transfers.last)
      end.to change(@alaine.unread_notifications, :count).by(1)
    end

    it 'should have the correct message' do
      @uesteibar.reject_transfer_request(@uesteibar.received_transfers.last)
      expect(@alaine.notifications.last.message).to eq "#{@uesteibar.username} rejected your transfer request"
    end
  end

  describe 'mark as read' do
    it 'should mark the notification as read' do
      @uesteibar.reject_transfer_request(@uesteibar.received_transfers.last)
      expect do
        @alaine.notifications.last.mark_as_read
      end.to change(@alaine.unread_notifications, :count).by(-1)
    end
  end
end
