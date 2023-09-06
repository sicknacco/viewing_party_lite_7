# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New Viewing Party' do
  before(:each) do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: 'movies123', password_confirmation: 'movies123')
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: 'movies123', password_confirmation: 'movies123')
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: 'movies123', password_confirmation: 'movies123')
    @user_4 = User.create!(name: 'Sammy', email: 'moives_are_okay_i_guess@gmail.com', password: 'movies123', password_confirmation: 'movies123')

    @movie = Movie.new({
                         id: 321,
                         original_title: 'Mambo Italiano',
                         vote_average: 5.8,
                         runtime: 89,
                         genres: [{ id: 35, name: 'Comedy' }, { id: 10_749, name: 'Romance' }],
                         overview: 'When an Italian man comes out of the closet, it affects both his life and his crazy family.'
                       })
  end

  describe 'When I visit the new viewing party page' do
    it 'displays a form to create a new viewing party', :vcr do
      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'
      
      visit new_party_path(@user_1.id, @movie.id)

      expect(page).to have_content('Mambo Italiano')
      expect(page).to have_content('Invite Other Users')
      fill_in :party_duration, with: @movie.runtime
      fill_in :party_date, with: Date.today
      fill_in :party_time, with: Time.now

      check(@user_2.id)
      check(@user_3.id)

      click_button 'Create Party'

      expect(current_path).to eq(dashboard_path(@user_1.id))
    end
  end
end
