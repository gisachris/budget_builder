require 'rails_helper'

RSpec.describe 'Edit Deal Page Testing', type: :system do
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

    # Create a deal
    @deal = Deal.create!(
      name: 'Old Deal Name',
      amount: 50,
      author: @user
    )

    @category_deal = CategoryDeal.create!(
      deal: @deal,
      category: @category
    )
  end

  describe 'page interactions' do
    before(:each) do
      sign_in @user
      visit edit_user_deal_path(@user, @deal)
    end

    it 'allows user to update a deal' do
      fill_in 'transaction[name]', with: 'Updated Deal Name'
      fill_in 'transaction[amount]', with: 75
      click_button 'Update'

      sleep 5

      expect(page).to have_css('.notice')
    end

    it 'page return to deal show page after successful update of a deal' do
      fill_in 'transaction[name]', with: 'Updated Deal Name'
      fill_in 'transaction[amount]', with: 75
      click_button 'Update'

      sleep 2

      expect(page).to have_current_path(user_deal_path(@user, @deal))
    end
  end
end
