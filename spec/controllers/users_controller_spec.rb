require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    include Devise::TestHelpers

    @user = User.create(
      username: 'uesteibar',
      email: 'uesteibar@live.com',
      password: 'uesteibar',
      password_confirmation: 'uesteibar'
    )
    @user.confirm!
    sign_in @user
  end

  describe 'GET #index' do
    context 'when the user is logged in' do
      it 'responds successfully with an HTTP 200 status code' do
        get :show, id: @user.id
        expect(response).to be_success
        expect(response.code.to_i).to eq(200)
      end

      it 'renders the show template' do
        get :show, id: @user.id
        expect(response).to render_template('show')
      end
    end

    context 'when the user is not logged in' do
      before(:each) do
        sign_out @user
      end

      it 'redirects to root' do
        get :show, id: @user.id
        expect(response).to redirect_to('/login')
      end
    end

    describe 'GET #edit' do
      context 'when the user is accessing his/her own edit page' do
        it 'responds successfully with an HTTP 200 status code' do
          get :edit, id: @user.id
          expect(response).to be_success
          expect(response.code.to_i).to eq(200)
        end

        it 'renders the edit template' do
          get :edit, id: @user.id
          expect(response).to render_template('edit')
        end
      end

      context "when the user is accessing someone else's edit page" do
        before(:each) do
          @new_user = User.create(
            username: 'alaine',
            email: 'alaine@live.com',
            password: 'alaine',
            password_confirmation: 'alaine'
          )
          @new_user.confirm!
          sign_out @user
          sign_in @new_user
        end

        it 'redirects to root' do
          get :edit, id: @user.id
          expect(response).to redirect_to('/')
        end
      end
    end

    describe 'GET #search' do
      before(:each) do
        @alaine = User.create(
          username: 'alaine',
          email: 'alaine@live.com',
          password: 'alaine',
          password_confirmation: 'alaine'
        )
        @alaine.confirm!

        @alen = User.create(
          username: 'alenesteibar',
          email: 'alenesteibar@live.com',
          password: 'alen',
          password_confirmation: 'alen'
        )
        @alen.confirm!
      end

      context 'when the user is logged in' do
        it 'responds successfully with an HTTP 200 status code' do
          get :search, term: "est"
          expect(response).to be_success
          expect(response.code.to_i).to eq(200)
        end

        it 'returns a json with the matching users' do
          get :search, term: "est"
          expect(response.body).to eq [@user, @alen].to_json
        end
      end

      context 'when the user is not logged in' do
        before(:each) do
          sign_out @user
        end

        it 'redirects to root' do
          get :show, id: @user.id
          expect(response).to redirect_to('/login')
        end
      end
    end
  end
end
