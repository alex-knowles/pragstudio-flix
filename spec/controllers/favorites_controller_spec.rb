require 'rails_helper'

describe FavoritesController do

  context "when not signed in" do

    before do
      @movie = Movie.create!(movie_attributes)
      @user = User.create!(user_attributes)
    end

    it "cannot access create" do
      post :create, params: { movie_id: @movie.id, user_id: @user.id }
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access destroy" do
      favorite = @movie.favorites.create!(user: @user)
      delete :destroy, params: { movie_id: @movie.id, id: favorite.id }
      expect(response).to redirect_to(signin_url)
    end

  end

end
