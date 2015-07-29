require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    before(:each) do
      @alaine = create(:alaine)
      @alaine.confirm!

      @alen = create(:alen)
      @alen.confirm!

      @book = create(:book)

      sign_in @alaine
    end

    context 'when the user is logged in' do
      it 'responds successfully with an HTTP 200 status code' do
        get :search, term: 'est'
        expect(response).to be_success
        expect(response.code.to_i).to eq(200)
      end

      it 'returns a json with the matching users' do
        get :search, term: 'est'
        expect(response).to render_template('search')
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @alaine
      end

      it 'redirects to login' do
        get :search, term: 'est'
        expect(response).to redirect_to('/login')
      end
    end
  end
end
