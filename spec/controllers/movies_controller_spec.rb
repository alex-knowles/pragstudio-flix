require 'rails_helper'

describe MoviesController do

  context "when not signed in" do

    it "cannot access create"

    it "cannot access edit"

    it "cannot access destroy" do
      movie = Movie.create!(movie_attributes)
      delete :destroy, params: { id: movie }
      expect(response).to redirect_to(signin_url)
    end

  end

  context "when signed in as a non-admin" do

    it "cannot access create"

    it "cannot access edit"

    it "cannot access destroy"

  end

end
