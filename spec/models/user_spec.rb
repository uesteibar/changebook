require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    before(:each) do
      @user_params = {
        username: "uesteibar",
        email: "uesteibar@example.com",
        password: "1234567890",
        password_confirmation: "1234567890"
      }
    end

    it "should create the user when all params are provided" do
      user = User.create(@user_params)
      expect(user.id).not_to be_falsy
    end

    it "should NOT create the user when username is empty" do
      expect do
        User.create!(@user_params.merge({username: ""}))
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "should NOT create the user when username is nil" do
      expect do
        User.create!(@user_params.merge({username: nil}))
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "should NOT create the user when email is empty" do
      expect do
        User.create!(@user_params.merge({email: ""}))
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "should NOT create the user when email is nil" do
      expect do
        User.create!(@user_params.merge({email: nil}))
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "should NOT create the user when password is empty" do
      expect do
        User.create!(@user_params.merge({password: ""}))
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "should NOT create the user when password is nil" do
      expect do
        User.create!(@user_params.merge({password: nil}))
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it "should NOT create the user when password and password_confirmation don't match" do
      expect do
        User.create!(@user_params.merge({password_confirmation: "12356790"}))
      end.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
