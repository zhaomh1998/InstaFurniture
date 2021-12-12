# Add a declarative step here for populating the DB with Listings.

Given /database is seeded/ do
  expect(@database_seeded).to be_truthy
end

Given /the following furniture items exist/ do |listings_table|
  listings_table.hashes.each do |listing|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that listing to the database here.
    Listing.create!(listing)
  end
end

# new feature
Then /(.*) furniture items should exist/ do |n_seeds|
  expect(Listing.count).to eq n_seeds.to_i
end

Then /(.*) users should exist/ do |n_seeds|
  expect(User.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body).to match(/#{e1}.*#{e2}/m)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following tags: (.*)/ do |uncheck, tag_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = tag_list.split(',')
  ratings.each do |tag|
    # tag_field = "tags_#{tag.lstrip}"
    tag_field = "#{tag.lstrip}"
    if uncheck
      step "I uncheck \"#{tag_field}\""
    else
      step "I check \"#{tag_field}\""
    end
  end
end

Then /I should see all the listings/ do
  # Make sure that all the Listings in the app are visible in the table
  # https://stackoverflow.com/questions/2986250/how-to-assert-on-number-of-html-table-rows-in-ruby-using-capybara-cucumber
  page.all('table#listings tr').count.should be Listing.count + 1
end

When /^I view listing (\d+)$/ do |listing_id|
  visit "/listings/#{listing_id}"
end

When /^I create listing "([^"]*)"$/ do |listing_name|
  Capybara.current_session.driver.submit :post, "/listings", { :listing => { :name => listing_name } }
end

When /^I edit listing (\d+)$/ do |listing_id|
  visit "/listings/#{listing_id}/edit"
end

When /^I submit edit to listing (\d+) renaming to "([^"]*)"$/ do |listing_id, listing_name|
  Capybara.current_session.driver.submit :put, "/listings/#{listing_id}", { :listing => { :name => listing_name } }
end

When /^I delete listing (\d+)$/ do |listing_id|
  Capybara.current_session.driver.submit :delete, "/listings/#{listing_id}", nil
end

When /^I click listing "([^"]*)"$/ do |listing_name|
  find("\##{listing_name}").click
end