require 'rails_helper'

RSpec.describe "User Discover Index '/users/:id/discover'", type: :feature do
  before(:each) do
    @user_1 = User.create!(name: "Jimmy", email: "movie_buff333@gmail.com")
    @user_2 = User.create!(name: "Timmy", email: "i_hate_movies@gmail.com")
    @user_3 = User.create!(name: "Tammy", email: "gamer4134@gmail.com")

    visit discover_path(@user_2.id)
  end

  describe "When I visit the '/users/:id/discover' path" do
    it "displays a Button to Discover Top Rated Movies" do
      expect(page).to have_button("Discover Top Rated Movies")
    end

    it "displays A text field to enter keyword(s) to search by movie title" do

    end

    it "displays A Button to Search by Movie Title" do

    end
  end
end