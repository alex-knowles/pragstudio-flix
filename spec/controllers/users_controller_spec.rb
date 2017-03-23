require 'rails_helper'

describe UsersController do

  context "when not signed in" do

    before do
      @user = User.create!(user_attributes)
      session[:user_id] = nil
    end

    it "cannot access index" do
      get :index
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access show" do
      get :show, params: { id: @user }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access edit" do
      get :edit, params: { id: @user }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access update" do
      patch :update, params: { id: @user, user: user_attributes(password: "") }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to(signin_url)
    end

  end

end
