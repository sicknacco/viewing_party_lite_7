require 'rails_helper'

RSpec.describe 'User Login' do
  describe 'Happy Path' do
    it 'can login a user with valid credentials' do
      user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: 'movies123', password_confirmation: 'movies123')
      visit root_path
      click_button 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Login Form')

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password
      click_button 'Log In'

      expect(current_path).to eq(dashboard_path(user_1))
      expect(page).to have_content("Welcome, #{user_1.name}!")
    end
  end

  describe 'Sad Path' do
    it 'cannot login a user with invalid credentials' do
      user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: 'movies123', password_confirmation: 'movies123')
      visit root_path
      click_button 'Log In'
      
      expect(current_path).to eq(login_path)
      expect(page).to have_content('Login Form')
      
      fill_in :email, with: user_1.email
      fill_in :password, with: 'funbucket'
      click_button 'Log In'
      
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry! Your credentials are bad.")
    end
  end
end