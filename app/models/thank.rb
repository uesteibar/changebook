class Thank < ActiveRecord::Base
  belongs_to :user
  belongs_to :recommendation

  validates_presence_of :user_id, :recommendation_id
  validate :different_user

  private

  def different_user
    if user.id == recommendation.user.id
      errors.add(:user_id, "a user can't thank his/her own recommendation")
    end
  end
end
