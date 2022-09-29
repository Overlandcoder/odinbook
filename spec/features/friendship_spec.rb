require 'rails_helper'

RSpec.describe 'Friendship', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:user2) { FactoryBot.create(:user, id: 2) }

  context 'when a user accepts a friend request' do
    before do
      login_as(user1)
      visit user_path(user2.id)
      click_on "Add Friend"
      login_as(user2)
      visit user_friend_requests_path(user2.id)
      click_on "Accept"
    end
  
    it 'creates the friendship for the request receiver' do
      visit user_friendships_path(user2.id)
      expect(page).to have_link "#{user1.username.capitalize}"
    end

    it 'does not add self as friend of self' do
      visit user_friendships_path(user2.id)
      expect(page).not_to have_link "#{user2.username.capitalize}"
    end

    it 'does not add self as friend of self' do
      visit user_friendships_path(user1.id)
      expect(page).not_to have_link "#{user1.username.capitalize}"
    end

    it 'creates the friendship for the request sender' do
      visit user_friendships_path(user1.id)
      expect(page).to have_link "#{user2.username.capitalize}"
    end

    it 'increments friends of request receiver by 1' do
      visit user_path(user2.id)
      expect(page).to have_content 'Friends: 1'
    end

    it 'increments friends of request sender by 1' do
      visit user_path(user1.id)
      expect(page).to have_content 'Friends: 1'
    end
  end
end
