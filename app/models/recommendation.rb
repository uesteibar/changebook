class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :user_id, :book_id, :comment

  after_create :create_events

  private

  def create_events
    user.followers.each do |follower|
      Event.create(
        user_id: follower.id,
        item_urn: "recommendation:#{id}"
      )
    end
  end
end
