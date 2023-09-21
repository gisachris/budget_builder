require 'rails_helper'

RSpec.describe 'Category Show Page Testing', type: :system do
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

    @deal = Deal.create!(
      name: 'clothes',
      amount: 300,
      author: @user
    )

    @category_deal = CategoryDeal.create!(
      deal: @deal,
      category: @category
    )
  end

  describe 'page components' do
    before(:each) do
      sign_in @user
      visit user_category_path(@user, @category)
    end

    it 'should have the category name' do
      expect(page).to have_content(@category.name)
    end

    it 'should have the category icon' do
      expect(page).to have_css('.cat_short_image')
    end

    it 'should display total amount from all deals in that category' do
      expect(page).to have_content("$#{@total}")
    end
  end

  describe 'page interactions' do
    before(:each) do
      sign_in @user
      visit user_category_path(@user, @category)
    end

    it 'should navigate to a transaction details page on transaction click' do
      click_on(@deal.name)
      expect(page).to have_current_path(user_deal_path(@user, @deal))
    end

    it 'Should navigate to the add new transactions page on click' do
      click_on('ADD TRANSACTION')
      expect(page).to have_current_path(new_user_deal_path(@user))
    end
  end
end
