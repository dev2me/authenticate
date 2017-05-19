require 'spec_helper'
require 'support/features/feature_helpers'

feature 'visitor at new user form, not signed in' do
  scenario 'visit with no arguments' do
    visit new_users_path
    expect(page).to have_current_path new_users_path
    within 'h2' do
      expect(page).to have_content /Sign up/i
    end
  end

  scenario 'defaults email to value provided in query string' do
    visit new_users_path(user: { email: 'dude@example.com' })
    expect(page).to have_selector 'input[value="dude@example.com"]'
  end
end

feature 'visitor at new user form, already signed in' do
  scenario 'redirects user to redirect_url' do
    user = create(:user, email: 'test.user@example.com')
    sign_in_with 'Test.USER@example.com', user.password
    visit new_users_path
    expect_path_is_redirect_url
  end
end