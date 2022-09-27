require 'rails_helper'

RSpec.describe 'Comment', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }
  let!(:user2) { FactoryBot.create(:user, id: 2) }
  let!(:post1) { FactoryBot.create(:post, author: user2) }

  before do
    login_as(user1)
    visit root_path
    click_on 'New Post'
    fill_in 'Title', with: 'first post'
    fill_in 'Body', with: 'my text'
    click_on 'Submit Post'
  end

  context 'when adding a comment' do
    before do
      fill_in 'New Comment', with: 'some comment text'
      click_on 'Post Comment'
    end

    it 'adds the comment' do
      expect(page).to have_content 'some comment text'
    end

    it 'increments comment count of the commenter by 1' do
      expect(user1.comments.count).to eq(1)
    end

    it 'increments comment count of the post by 1' do
      visit post_path(post1)
      fill_in 'New Comment', with: 'a comment'
      click_on 'Post Comment'
      expect(post1.comments.count).to eq(1)
    end
  end

  context 'when viewing a post with a comment' do
    before do
      visit post_path(post1)
      fill_in 'New Comment', with: 'a comment'
      click_on 'Post Comment'
    end

    it 'displays the post' do
      expect(page).to have_content "#{post1.body}"
    end

    it 'displays the comment' do
      expect(page).to have_content 'a comment'
    end
  end
end
