require 'rails_helper'

RSpec.describe 'Comment', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:user2) { FactoryBot.create(:user, id: 2) }
  let!(:post1) { FactoryBot.create(:post, author: user2) }

  context 'when adding a comment' do
    before do
      login_as(user1)
      visit root_path
      click_on 'Comment'
      fill_in 'Comment:', with: 'some comment text'
      click_on 'Post Comment'
      visit root_path
    end

    it 'adds the comment' do
      expect(page).to have_content 'some comment text'
    end

    it 'increments comment count of the commenter by 1' do
      expect(user1.comments.count).to eq(1)
    end

    it 'increments comment count of the post by 1' do
      expect(post1.comments.count).to eq(1)
    end
  end

  context 'when viewing a post with a comment' do
    before do
      login_as(user1)
      visit post_path(post1)
      click_on 'Comment'
      fill_in 'Comment:', with: 'a comment'
      click_on 'Post Comment'
      visit post_path(post1)
    end

    it 'displays the post' do
      expect(page).to have_content "#{post1.body}"
    end

    it 'displays the comment' do
      expect(page).to have_content 'a comment'
    end
  end
end
