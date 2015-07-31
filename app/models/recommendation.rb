class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :user_id, :book_id, :comment

  after_create :create_events
  before_destroy :destroy_events

  private

  def create_events
    user.followers.each do |follower|
      Event.create(
        user_id: follower.id,
        item_urn: "recommendation:#{id}"
      )
    end
  end

  def destroy_events
    events = Event.where(item_urn: "ownership:#{id}")
    events.destroy_all
  end
end
