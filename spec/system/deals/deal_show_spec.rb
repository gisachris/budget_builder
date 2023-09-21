require 'rails_helper'

RSpec.describe 'Deals Show Page Testing', type: :system do
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
      author: @user)

    @icon_path = Rails.root.join('app','assets','images','test_image.jpg')
    
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
      visit user_deal_path(@user,@deal)
    end

    it 'should see the deal name' do
      expect(page).to have_content(@deal.name)
    end

    it 'should see the deal amount' do
      expect(page).to have_content(@deal.amount)
    end

    it 'should see the deal creation time' do
      expect(page).to have_content(@deal.created_at)
    end

    it 'should see the category it belongs to' do
      expect(page).to have_content(@category.name)
    end
  end

  describe 'page Interactions' do
    before(:each) do
      sign_in @user
      visit user_deal_path(@user,@deal)
    end

    it 'should navigate to the edit deal page on click' do
      click_on('edit')

      expect(page).to have_current_path(edit_user_deal_path(@user,@deal))
    end
  end
end