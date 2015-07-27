require 'rails_helper'

RSpec.describe Following, type: :model do
  before(:each) do
    @uesteibar = User.create(
      username: 'uesteibar',
      email: 'uesteibar@live.com',
      password: 'uesteibar',
      password_confirmation: 'uesteibar'
    )
    @uesteibar.confirm!

    @alaine = User.create(
      username: 'alaine',
      email: 'alaine@live.com',
      password: 'alaine',
      password_confirmation: 'alaine'
    )
    @alaine.confirm!
  end

  describe 'user follows other user' do
    it 'should create a follower - followed reference between users' do
      @uesteibar.follow(@alaine)
      expect(@alaine.followers.last.id).to eq @uesteibar.id
      expect(@uesteibar.following.last.id).to eq @alaine.id
    end
  end

  describe 'user unfollows other user' do
    it 'should destroy the follower - followed reference between the users' do
      @uesteibar.follow(@alaine)
      @uesteibar.unfollow(@alaine)
      expect(@alaine.followers.count).to eq 0
      expect(@uesteibar.following.count).to eq 0
    end
  end
end
