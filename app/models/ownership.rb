class Ownership < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  has_many :transfers

  validates_presence_of :user_id, :book_id

  after_create :create_events
  before_destroy :destroy_events

  def offering?
    to_give_away || to_exchange
  end

  def create_events
    if offering?
      user.followers.each do |follower|
        Event.create(
          user_id: follower.id,
          item_urn: "ownership:#{id}"
        )
      end
    end
  end

  def destroy_events
    events = Event.where(item_urn: "ownership:#{id}")
    events.destroy_all
  end
end
