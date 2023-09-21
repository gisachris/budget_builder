require 'rails_helper'

RSpec.describe 'New Category Form Page Testing', type: :system do
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
  end

  describe 'page interactions' do
    before(:each) do
      sign_in @user
      visit new_user_category_path(@user)
    end

    it 'allows user to create a new category' do
      fill_in 'category[name]', with: 'Test Category'
      attach_file 'category[icon]', Rails.root.join('app','assets','images','test_image.jpg')
      click_button 'Create Category'

      sleep 5

      expect(page).to have_css('.notice')
    end

    it 'page return to categories index page after succesful creation of a category' do
      fill_in 'category[name]', with: 'Test Category'
      attach_file 'category[icon]', Rails.root.join('app','assets','images','test_image.jpg')
      click_button 'Create Category'

      sleep 2

      expect(page).to have_current_path(user_categories_path(@user))
    end
  end
end
