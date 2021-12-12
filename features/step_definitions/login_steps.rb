Given(/^User not logged in$/) do
  visit '/logout'
end

Given(/^User logged in$/) do
  visit '/mock_login'
end

Given(/^User logged in as (\d+)$/) do |uid|
  visit "/mock_login/#{uid}"
end
