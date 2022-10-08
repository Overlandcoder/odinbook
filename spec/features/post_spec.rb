require 'rails_helper'

RSpec.describe 'Creating posts', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }

  before do
    login_as(user1)
    visit root_path
    click_on 'Create Post'
    fill_in "What's on your mind?", with: "Some text"
    click_on 'Post'
  end

  context 'when creating a valid post' do
    it 'creates the post' do
      expect(page).to have_content "Some text"
    end

    it 'increases post count of the user' do
      expect(user1.posts.count).to eq(1)
    end
  end

  context 'when viewing a post' do
    it 'contains the author info' do
      expect(page).to have_link "#{user1.username.capitalize}"
    end
  end
end
