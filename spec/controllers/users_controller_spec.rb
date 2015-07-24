require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = User.create(
    username: "uesteibar",
    email: "uesteibar@live.com",
    password: "uesteibar",
    password_confirmation: "uesteibar"
    )
    session[:user_id] = @user.id
  end

  describe 'GET #index' do
   context 'when the user is logged in' do
     it 'responds successfully with an HTTP 200 status code' do
       get :show, id: @user.id
       expect(response).to be_success
       expect(response.code.to_i).to eq(200)
     end

     it 'renders the index template' do
       get :show, id: @user.id
       expect(response).to render_template('show')
     end
   end

   context 'when the user is not logged in' do
     before(:each) do
       session.clear
     end

     it 'redirects to root' do
       get :show, id: @user.id
       expect(response).to redirect_to('/login')
     end
   end
 end
end
