require 'rails_helper'

RSpec.describe 'Like', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:post1) { FactoryBot.create(:post, author: user1) }

  context 'when liking a post' do
    before do
      login_as(user1)
      visit post_path(post1.id)
      click_on 'Like'
    end

    it 'creates a like for the post' do
      expect(post1.likes.count).to eq(1)
    end

    it 'creates a like for the user' do
      expect(user1.likes.count).to eq(1)
    end

    it 'shows that the post has 1 like' do
      visit post_path(post1)
      expect(page).to have_content '1 Like'
    end

    it 'shows the Unlike button' do
      visit post_path(post1)
      expect(page).to have_button 'Liked'
    end
  end

  context 'when unliking a post' do
    before do
      login_as(user1)
      visit post_path(post1.id)
      click_on 'Like'
      visit post_path(post1)
    end

    it 'allows user to Like the post again' do
      click_on 'Liked'
      visit post_path(post1)
      expect(page).to have_button 'Like'
    end

    it 'shows 0 Likes on the post' do
      click_on 'Liked'
      visit post_path(post1)
      expect(page).to have_content '0 Likes'
    end
  end
end
