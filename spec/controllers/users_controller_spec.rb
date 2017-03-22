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

    it "cannot access edit"

    it "cannot access update"

    it "cannot access show"

  end

end
