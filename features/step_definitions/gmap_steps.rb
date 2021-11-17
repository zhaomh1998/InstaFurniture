Given(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see a map on the webpage/) do
  #expect(page).to find('#map', wait:100)
  page.has_css?('#map', wait:100)
end


