# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page', type: :feature do
  before :each do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: 'movies123', password_confirmation: 'movies123')
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: 'movies123', password_confirmation: 'movies123')
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: 'movies123', password_confirmation: 'movies123')
  end
  describe '#index' do
    it 'displays the title of the application' do
      visit root_path

      expect(page).to have_content('Viewing Party!')
    end

    it 'has a button to create a new user' do
      visit root_path

      within '#new_user' do
        expect(page).to have_button('Create New User')
        click_button('Create New User')
      end
      expect(current_path).to eq(register_path)
    end

    it 'Does NOT display a list of existing users unless logged in' do
      visit root_path

      expect(page).to_not have_content('Existing Users')
      expect(page).to_not have_content(@user_1.email)
      expect(page).to_not have_content(@user_2.email)
      expect(page).to_not have_content(@user_3.email)
    end

    it "DISPLAYS existing users on landing page when logged in" do
      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'
      visit root_path

      within '#existing_users' do
        expect(page).to have_content('Existing Users')
        expect(page).to have_content(@user_1.email)
        expect(page).to have_content(@user_2.email)
        expect(page).to have_content(@user_3.email)

        expect(page).to_not have_link(@user_1.email)
        expect(page).to_not have_link(@user_2.email)
        expect(page).to_not have_link(@user_3.email)
      end
    end

    it 'has a home link on every page' do
      visit root_path
      click_link('Home')
      expect(current_path).to eq(root_path)

      visit dashboard_path(@user_1.id)
      click_link('Home')
      expect(current_path).to eq(root_path)
    end

    it 'cannot visit dashboard without logging in' do
      visit root_path
      visit dashboard_path(@user_1.id)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be logged in or registered to access your dashboard")
    end
  end
end
