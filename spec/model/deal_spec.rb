require 'rails_helper'

RSpec.describe 'Deal Model Testing' do
  before(:each) do
    @user = User.create!(
      name: 'gisachris',
      email: 'gisa@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123')
    
    @deal = Deal.create!(
      name: 'clothes',
      amount: 300,
      author: @user
    )
  end

  after(:each) do
    Deal.delete_all
    User.delete_all
  end

  it 'should be valid with valid attributes' do
    expect(@deal).to be_valid
  end

  it 'Should not be valid with invalid attributes' do
    @deal.name = nil
    expect(@deal).to_not be_valid
  end

  it 'should not be valid with wrong datatype' do
    @deal.amount = 'text'
    expect(@deal).to_not be_valid
  end

  it 'should have the user as the author' do
    expect(@deal.author).to eq(@user)
  end
end