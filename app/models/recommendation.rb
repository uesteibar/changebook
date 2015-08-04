class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book, touch: true

  has_many :thanks

  validates_presence_of :user_id, :book_id, :comment, :valoration
  validate :correct_valoration

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

  def correct_valoration
    unless valoration >= 0 && valoration <= 100
      errors.add(:valoration, "valoration should be between 0 and 100")
    end
  end
end
