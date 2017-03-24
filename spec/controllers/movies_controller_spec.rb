require 'rails_helper'

describe MoviesController do

  context "when not signed in" do

    before do
      @movie = Movie.create!(movie_attributes)
    end

    it "cannot access new" do
      get :new
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access create" do
      post :create, params: { movie: movie_attributes }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access edit" do
      get :edit, params: { id: @movie }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access update" do
      post :update, params: { 
        id: @movie,
        movie: movie_attributes(title: "Foo Bar 2")
      }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @movie }
      expect(response).to redirect_to(signin_url)
    end

  end

  context "when signed in as a non-admin" do

    before do
      user = User.create!(user_attributes)
      session[:user_id] = user.id
    end

    it "cannot access new" do
      get :new
      expect(response).to redirect_to(root_url)
    end

    it "cannot access create"

    it "cannot access edit"

    it "cannot access update"

    it "cannot access destroy"

  end

end
