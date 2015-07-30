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

  describe '#request_transfer' do
    it 'should create a transfer request' do
      transfer = @uesteibar.request_transfer(dest_user: @alaine, book: @book)
      expect(@uesteibar.sent_transfers.last).to eq transfer
      expect(@alaine.received_transfers.last).to eq transfer
      expect(@uesteibar.sent_transfers.last.accepted).to eq false
    end
  end

  describe '#accept!' do
    it 'should transfert a book to the new owner' do
      @uesteibar.request_transfer(dest_user: @alaine, book: @book)
      @alaine.received_transfers.last.accept
      expect(@alaine.books.last).to eq @book
      expect(@alaine.received_transfers.last.accepted).to eq true
      expect(@uesteibar.books.size).to eq 0
    end
  end
end
