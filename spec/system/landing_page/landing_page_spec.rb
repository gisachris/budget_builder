require 'rails_helper'

RSpec.describe 'Landing page testing', type: :system do
  describe 'Testing page components' do
    before(:each) do
      visit root_path
    end

    # page components
    it 'should visit the root page' do
      expect(page).to have_current_path(root_path)
    end

    it 'should have an App Logo' do
      expect(page).to have_css('.logo_outside')
    end

    it 'should have a login button' do
      expect(page).to have_content('Login')
    end

    it 'should have a signup button' do
      expect(page).to have_content('SignUp')
    end
  end

  describe 'Testing page interactions' do
    before(:each) do
      visit root_path
    end

    # interactions
    it 'should go to login page on click of login page' do
      click_on('Login')
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'should go to signup page on click of signup page' do
      click_on('SignUp')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
