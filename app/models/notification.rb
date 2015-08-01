class Notification < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :message

  def mark_as_read
    update_attributes(read: true)
  end
end
