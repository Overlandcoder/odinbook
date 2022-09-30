require 'rails_helper'

RSpec.describe 'Creating posts', type: :feature do
  let!(:user1) { FactoryBot.create(:user, id: 1) }

  before do
    login_as(user1)
    visit root_path
    click_on 'Create Post'
    fill_in 'Title', with: "Some post"
    fill_in 'Body', with: "Some text"
    click_on 'Submit Post'
  end

  context 'when creating a valid post' do
    it 'creates the post' do
      expect(page).to have_content "New post created."
    end

    it 'increases post count of the user' do
      expect(user1.posts.count).to eq(1)
    end
  end

  context 'when viewing a post' do
    it 'contains the author info' do
      expect(page).to have_content "By: #{user1.username}"
    end
  end
end
