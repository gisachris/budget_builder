require 'rails_helper'

RSpec.describe 'Category Deals Joint Tables Testing' do
  before(:each) do
    @user = User.create!(
      name: 'gisachris',
      email: 'gisa@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123'
    )

    @category = Category.create!(
      name: 'groceries',
      author: @user
    )

    @deal = Deal.create!(
      name: 'clothes',
      amount: 300,
      author: @user
    )

    @category_deal = CategoryDeal.create!(
      category: @category,
      deal: @deal
    )
  end
  after(:each) do
    CategoryDeal.delete_all
    Deal.delete_all
    Category.delete_all
    User.delete_all
  end

  it 'Should be valid with valid attributes' do
    expect(@category_deal).to be_valid
  end

  it 'should have specified deal for deal association' do
    expect(@category_deal.deal).to eq(@deal)
  end

  it 'should have specified category for category association' do
    expect(@category_deal.category).to eq(@category)
  end
end
