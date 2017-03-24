require 'rails_helper'

describe MoviesController do

  context "when not signed in" do

    before do
      @movie = Movie.create!(movie_attributes)
      @expected_url = signin_url
    end

    it "cannot access new" do
      get :new
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access create" do
      post :create, params: { movie: movie_attributes }
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access edit" do
      get :edit, params: { id: @movie }
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access update" do
      post :update, params: {
        id: @movie,
        movie: movie_attributes(title: "Foo Bar 2")
      }
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @movie }
      expect(response).to redirect_to(@expected_url)
    end

  end

  context "when signed in as a non-admin" do

    before do
      @movie = Movie.create!(movie_attributes)
      user = User.create!(user_attributes)
      session[:user_id] = user.id
      @expected_url = root_url
    end

    it "cannot access new" do
      get :new
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access create" do
      post :create, params: { movie: movie_attributes }
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access edit" do
      get :edit, params: { id: @movie }
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access update" do
      patch :update, params: {
        id: @movie,
        movie: movie_attributes(title: "Foo Bar 2")
      }
      expect(response).to redirect_to(@expected_url)
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @movie }
      expect(response).to redirect_to(@expected_url)
    end

  end

end
