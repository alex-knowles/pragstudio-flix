require 'rails_helper'

describe UsersController do

  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do

    before do
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

  context "when signed in" do

    before do
      @some_other_user = User.create!(user_attributes(
        name: "Dwigt",
        email: "dwigt@schrute.org"
      ))
      session[:user_id] = @user.id
    end

    it "cannot edit some other user" do
      get :edit, params: { id: @some_other_user }
      expect(response).to redirect_to(root_url)
    end

    it "cannot update some other user" do
      patch :update, params: { id: @some_other_user, user: user_attributes(name: "Dwight", password: "") }
      expect(response).to redirect_to(root_url)
    end

    it "cannot destroy some other user" do
      delete :destroy, params: { id: @some_other_user }
      expect(response).to redirect_to(root_url)
    end

  end

end
