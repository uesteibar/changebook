require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar

    @alaine = create(:alaine)
    @alaine.confirm!
  end

  describe "POST #create" do
    it "responds successfully with an HTTP 201 status code" do
      post :create, id: @alaine.id
      expect(response).to be_success
      expect(response.code.to_i).to eq(201)
    end

    it "follows the given user" do
      post :create, id: @alaine.id
      expect(@uesteibar.following.last.id).to eq @alaine.id
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      post :create, id: @alaine.id
    end

    it "responds successfully with an HTTP 200 status code" do
      delete :destroy, id: @alaine.id
      expect(response).to be_success
      expect(response.code.to_i).to eq(200)
    end

    it "unfollows the given user" do
      delete :destroy, id: @alaine.id
      expect(@uesteibar.following.count).to eq 0
    end
  end
end
