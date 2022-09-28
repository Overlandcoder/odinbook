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
      visit user_path(user2.id)
    end

    it 'displays the profile' do
      expect(page).to have_content "Viewing #{user2.username.capitalize}'s Profile"
    end
  end

  context 'when sending a friend request' do
    before do
      login_as(user1)
      visit user_path(user2.id)
    end

    it 'increments sent_friend_requests for the user that clicks Add Friend' do
      expect { click_on "Add Friend" }.
        to change { user1.sent_friend_requests.count }.from(0).to(1)
    end

    it 'increments received_friend_requests for the user receiving the request' do
      expect { click_on "Add Friend" }.
        to change { user2.received_friend_requests.count }.from(0).to(1)
    end

    it 'sends the request to the correct user' do
      click_on "Add Friend"
      expect(user1.sent_friend_requests.first.receiver).to eq(user2)
    end

    it 'other user receives the request from the correct user' do
      click_on "Add Friend"
      expect(user2.received_friend_requests.first.sender).to eq(user1)
    end
  end

  context 'when a user has a friend request' do
    before do
      login_as(user1)
      visit user_path(user2.id)
      click_on "Add Friend"
      login_as(user2)
      visit user_path(user2.id)
    end

    it 'displays the correct amount of friend requests' do
      expect(page).to have_content "Friend Requests: 1"
    end

    it 'shows the correct friend request' do
      visit user_friend_requests_path(user2.id)
      expect(page).to have_content "From: #{user1.username}"
    end
  end

  context 'when a user accepts a friend request' do
    before do
      login_as(user1)
      visit user_path(user2.id)
      click_on "Add Friend"
      login_as(user2)
      visit user_friend_requests_path(user2.id)
      click_on "Accept Request"
    end
  
    it 'creates the friendship for the request receiver' do
      expect(user2.friends).to include(user1)
    end

    it 'does not add self as friend of self' do
      expect(user2.friends).not_to include(user2)
    end

    it 'does not add self as friend of self' do
      expect(user1.friends).not_to include(user1)
    end

    it 'creates the friendship for the request sender' do
      expect(user1.friends).to include(user2)
    end

    it 'increments friends of request receiver by 1' do
      expect(user2.friends.count).to eq(1)
    end

    it 'increments friends of request sender by 1' do
      expect(user1.friends.count).to eq(1)
    end
  end

  context 'when viewing own profile' do
    before do
      login_as(user1)
      visit user_path(user1.id)
    end

    it 'does not show Add Friend button' do
      expect(page).not_to have_button "Add Friend"
    end
  end
end

# To open test coverage report:
# xdg-open coverage/index.html
