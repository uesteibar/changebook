
RSpec.describe "Followings", type: :request do
  before(:each) do
    create(:book)
    create(:book)

    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar
  end

  describe 'GET /api/books' do
    skip 'should return all the books' do
      get "/api/books", format: :json
      puts response.body
      expect(JSON.parse(response.body).length).to eq 2
    end
  end
end
