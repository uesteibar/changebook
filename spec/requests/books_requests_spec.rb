RSpec.describe "Followings", type: :request do
  before(:each) do
    create(:book)
  end

  describe 'GET /api/books/title' do
    it 'should return the titles of all the books' do
      get "/api/books", format: :json
      expect(JSON.parse(response.body).length).to eq 1
    end
  end
end
