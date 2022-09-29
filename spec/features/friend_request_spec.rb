require 'rails_helper'

RSpec.describe 'FriendRequest', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:user2) { FactoryBot.create(:user, id: 2) }

  context 'when a friend request is sent' do
    before do
      login_as(user1)
      visit user_path(user2.id)
    end

    it 'increments sent_friend_requests of the sender by 1' do
      expect { click_on 'Add Friend' }.
        to change { user1.sent_friend_requests.count }.from(0).to(1)
    end

    it 'increments received_friend_requests of the receiver by 1' do
      expect { click_on 'Add Friend' }.
        to change { user2.received_friend_requests.count }.from(0).to(1)
    end

    it 'creates 1 friend request object only' do
      expect { click_on 'Add Friend' }.
        to change { FriendRequest.all.count }.from(0).to(1)
    end

    it 'sends the request to the correct user' do
      click_on 'Add Friend'
      visit user_path(user2.id)
      expect(page).to have_button 'Cancel Friend Request'
    end

    it 'other user receives the request from the correct user' do
      click_on 'Add Friend'
      login_as(user2)
      visit user_path(user2.id)
      expect(page).to have_content 'Friend Requests: 1'
    end
  end

  context 'when a user has a friend request' do
    before do
      login_as(user1)
      visit user_path(user2.id)
      click_on 'Add Friend'
      login_as(user2)
      visit user_path(user2.id)
    end

    it 'displays the correct amount of friend requests' do
      expect(page).to have_content 'Friend Requests: 1'
    end

    it 'shows the correct friend request' do
      visit user_friend_requests_path(user2.id)
      expect(page).to have_content "From: #{user1.username}"
    end
  end

  context 'when a friend request is accepted' do
    before do
      login_as(user1)
      visit user_path(user2.id)
      click_on 'Add Friend'
      login_as(user2)
      visit user_friend_requests_path(user2.id)
    end

    it 'deletes the friend request' do
      expect { click_on 'Accept' }.
        to change { FriendRequest.all.count}.from(1).to(0)
    end

    it 'deletes the friend request for the sender' do
      expect { click_on 'Accept' }.
        to change { user1.sent_friend_requests.count }.from(1).to(0)
    end

    it 'deletes the friend request for the receiver' do
      expect { click_on 'Accept' }.
        to change { user2.received_friend_requests.count }.from(1).to(0)
    end
  end

  context 'when a friend request is cancelled' do
    before do
      login_as(user1)
      visit user_path(user2.id)
      click_on 'Add Friend'
    end

    it 'shows the Add Friend button again' do
      visit user_path(user2.id)
      click_on 'Cancel Friend Request'
      visit user_path(user2.id)
      expect(page).to have_button 'Add Friend'
    end
  end
end
