require 'rails_helper'

RSpec.describe 'New Deal Form Page Testing', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create!(
      name: 'gisachris',
      email: 'gisa@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123'
    )

    # Confirm the user's email
    @user.confirm

    @category = Category.create!(
      name: 'groceries',
      author: @user
    )

    @icon_path = Rails.root.join('app', 'assets', 'images', 'test_image.jpg')

    @category.icon.attach(io: File.open(@icon_path), filename: 'test_image.jpg')
  end

  describe 'page interactions' do
    before(:each) do
      sign_in @user
      visit new_user_deal_path(@user)
    end

    it 'allows user to create a new deal' do
      fill_in 'transaction[name]', with: 'Test Deal'
      fill_in 'transaction[amount]', with: 100
      select 'groceries', from: 'transaction[category_id]'
      click_button 'Create Transaction'

      sleep 5

      expect(page).to have_css('.notice')
    end

    it 'page return to categories show page after successful creation of a deal' do
      fill_in 'transaction[name]', with: 'Test Deal'
      fill_in 'transaction[amount]', with: 100
      select 'groceries', from: 'transaction[category_id]'
      click_button 'Create Transaction'

      sleep 2

      expect(page).to have_current_path(user_category_path(@user, @category))
    end
  end
end
