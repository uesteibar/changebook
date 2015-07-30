class Transfer < ActiveRecord::Base
  belongs_to :ownership
  belongs_to :user

  def accept!
    update_attributes(accepted: true)
    transfer_book_ownership
  end

  private

  def transfer_book_ownership
    user.ownerships.create(book_id: ownership.book.id)
    ownership.destroy
  end

end
