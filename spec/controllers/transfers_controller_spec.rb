require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar
  end

  describe 'GET #index' do
    context 'when the user is logged in' do
      it 'responds successfully with an HTTP 200 status code' do
        get :index, user_id: @uesteibar.id
        expect(response).to be_success
        expect(response.code.to_i).to eq(200)
      end

      it 'renders the show template' do
        get :index, user_id: @uesteibar.id
        expect(response).to render_template('index')
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @uesteibar
      end

      it 'redirects to root' do
        get :index, user_id: @uesteibar.id
        expect(response).to redirect_to('/login')
      end
    end
  end
end
