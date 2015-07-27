RSpec.describe "Followings", type: :request do
  before(:each) do
    @uesteibar = create(:uesteibar)
    # sign_in @uesteibar
    # FIXME - make the user sign_in in :request type specs
    @alaine = create(:alaine)
  end

  describe "POST /users/:id/follow" do
    skip "responses with http status 200" do
      post "/users/#{@alaine.id}/follow", format: :json

      expect(response).to have_http_status(201)
    end

    skip "follows the given user" do
      expect do
        post "/users/#{@alaine.id}/follow", format: :json
      end.to change(Following, :count).by(1)
    end
  end

  describe "DELETE /users/:id/unfollow" do
    skip "responses with http status 200" do
      delete "/users/#{@alaine.id}/unfollow", format: :json

      expect(response).to have_http_status(200)
    end

    skip "unfollows the given user" do
      expect do
        delete "/users/#{@alaine.id}/unfollow", format: :json
      end.to change(Following, :count).by(-1)
    end
  end
end
