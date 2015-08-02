require 'rails_helper'

RSpec.describe Transfer, type: :model do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!

    @alaine = create(:alaine)
    @alaine.confirm!

    @book = create(:book)
    @uesteibar.ownerships.create(book_id: @book.id, to_give_away: true)
  end

  after(:each) do
    Book.destroy_all
    Ownership.destroy_all
  end

  describe '#request_transfer' do
    it 'should create a transfer request' do
      transfer = @alaine.request_transfer(@uesteibar.ownerships.last)
      expect(@alaine.sent_transfers.last).to eq transfer
      expect(@uesteibar.received_transfers.last).to eq transfer
      expect(@alaine.sent_transfers.last.accepted).to eq false
    end
  end

  describe '#accept!' do
    it 'should transfert a book to the new owner' do
      @alaine.request_transfer(@uesteibar.ownerships.last)
      @uesteibar.received_transfers.last.accept!
      expect(@alaine.books.last).to eq @book
      expect(@uesteibar.received_transfers.size).to eq 0
      expect(@uesteibar.books.size).to eq 0
    end
  end
end
