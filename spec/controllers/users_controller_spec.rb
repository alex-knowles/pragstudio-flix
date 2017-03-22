require 'rails_helper'

describe UsersController do

  context "when not signed in" do

    it "cannot access index" do
      user = User.create!(user_attributes)
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access show"

    it "cannot access edit"

    it "cannot access update"

    it "cannot access show"

  end

end
