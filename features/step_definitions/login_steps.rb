Given(/^User not logged in$/) do
  visit '/logout'
end

Given(/^User logged in$/) do
  visit '/mock_login'
end

Given(/^User logged in as (\d+)$/) do |uid|
  visit "/mock_login/#{uid}"
end

Given(/^User logged in with OAuth/) do
  visit "/auth/google_oauth2/callback"
end

Then(/^I can see "([^"]*)" logged in$/) do |user_name|
  step "I should see \"Welcome, #{user_name}\""
end
