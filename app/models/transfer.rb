class Transfer < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :dest_user, class_name: 'User', foreign_key: 'dest_user_id'

  def accept
    update_attributes(accepted: true)
    transfer_book_ownership
  end

  private

  def transfer_book_ownership
    ownership = user.ownerships.find_by(book_id: book.id)
    dest_user.ownerships.create(book_id: ownership.book.id)
    ownership.destroy
  end

end
