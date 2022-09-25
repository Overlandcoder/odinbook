require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:user2) { FactoryBot.create(:user, id: 2) }

  context 'when not logged in' do
    it 'requires login to continue to app' do
      visit root_path
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end

  context 'when trying to log in' do
    it 'logs the user in' do
      login_as(user1)
      visit root_path
      expect(page).to have_content "Logged in as #{user1.email}"
    end
  end

  context 'when viewing profile of another user' do
    before do
      login_as(user1)
      visit user_path(2)
    end

    it 'displays the profile' do
      expect(page).to have_content "Viewing #{user2.username.capitalize}'s Profile"
    end
  end

  context 'when sending a friend request' do
    before do
      login_as(user1)
      visit user_path(2)
      click_on "Add Friend"
    end

    it 'sends a friend request to the other user' do
      expect(user1.friend_requests_sent.count).to eq(1)
    end

    it 'other user receives a friend request' do
      expect(user2.friend_requests_received.count).to eq(1)
    end

    it 'sends the request to the correct user' do
      expect(user1.friend_requests_sent.first.receiver).to eq(user2)
    end

    it 'other user receives the request from the correct user' do
      expect(user2.friend_requests_received.first.sender).to eq(user1)
    end
  end
end
