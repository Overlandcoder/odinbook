require 'rails_helper'

RSpec.describe 'Like', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:post1) { FactoryBot.create(:post, author: user1) }

  context 'when liking a post' do
    before do
      login_as(user1)
      visit post_path(post1.id)
      click_on "Like"
    end

    it 'creates a like' do
      expect(Like.all.count).to eq(1)
    end

    it 'creates a like for the post' do
      expect(post1.likes.count).to eq(1)
    end

    it 'creates a like for the user' do
      expect(user1.likes.count).to eq(1)
    end

    it 'shows that the post has 1 like' do
      expect(page).to have_content '1 Like'
    end
  end
end
