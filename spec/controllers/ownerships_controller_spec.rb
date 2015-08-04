require 'rails_helper'

RSpec.describe OwnershipsController, type: :controller do
  before(:each) do
    @uesteibar = create(:uesteibar)
    @uesteibar.confirm!
    sign_in @uesteibar

    @book = create(:book)
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response.code.to_i).to eq(200)
    end

    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'create a ownership' do
    it "responds successfully with an HTTP 201 status code" do
      post :create, ownership: {book_id: @book.id, to_give_away: true}
      expect(response).to be_success
      expect(response.code.to_i).to eq(201)
    end

    it 'should create a ownership' do
      expect do
        post :create, ownership: {book_id: @book.id, to_give_away: true}
      end.to change(Ownership, :count).by(1)
    end

    it 'should NOT create a rommendation when book_id is missing' do
      expect do
        post :create, ownership: {book_id: nil, to_give_away: true}
      end.to change(Ownership, :count).by(0)
    end
  end

  describe 'destroy a ownership' do
    before(:each) do
      @uesteibar.ownerships.create(book_id: @book.id, to_give_away: true)
    end

    it "responds successfully with an HTTP 200 status code" do
      post :destroy, id: @uesteibar.ownerships.last.id, user_id: @uesteibar.id
      expect(response).to redirect_to user_path(@uesteibar)
    end

    it 'should create a ownership' do
      expect do
        delete :destroy, id: @uesteibar.ownerships.last.id, user_id: @uesteibar.id
      end.to change(Ownership, :count).by(-1)
    end
  end
end
