require 'rails_helper'

RSpec.describe 'Category Index Page Testing', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create!(
      name: 'gisachris',
      email: 'gisa@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123')

    # Confirm the user's email
    @user.confirm
    
    @category = Category.create!(
      name: 'groceries',
      author: @user)

    @icon_path = Rails.root.join('app','assets','images','test_image.jpg')
    
    @category.icon.attach(io: File.open(@icon_path), filename: 'test_image.jpg')
  end

  describe 'page components' do
    before(:each) do
      sign_in @user
      visit categories_index_path(@user)
    end

    it 'should show category name on page' do
      expect(page).to have_content(@category.name)
    end

    it 'should show category icon on page' do
      expect(page).to have_css('.category_icon')
    end

    it 'Should have a total of zero with no tranactions made' do
      expect(page).to have_content('$0')
    end
  end

  describe 'page interactions' do
    before(:each) do
      sign_in @user
      visit categories_index_path(@user)
    end

    it 'should navigate to the categories showpage when a category is clicked' do
      within('.single_category') do
        click_link(@category.name)
      end
      expect(page).to have_current_path(user_category_path(@user,@category))
    end

    it 'should navigate to new category page when add category button is clicked' do
      click_on('ADD CATEGORY')
      expect(page).to have_current_path(new_user_category_path(@user))
    end
  end
end