require 'rails_helper'

RSpec.describe 'Creating posts', type: :feature do
  let!(:johndoe) { FactoryBot.create(:user) }

  before do
    login_as(johndoe)
    visit root_path
    click_on 'New Post'
    fill_in 'Title', with: "Some post"
    fill_in 'Body', with: "Some text"
    click_on 'Submit Post'
  end

  context 'when creating a valid post' do
    it 'creates the post' do
      expect(page).to have_content "New post created."
    end

    it 'increases the number of posts count of the user' do
      expect(johndoe.posts.count).to eq(1)
    end
  end

  context 'when viewing a post' do
    it 'contains the author info' do
      expect(page).to have_content "By: #{johndoe.username}"
    end
  end
end
