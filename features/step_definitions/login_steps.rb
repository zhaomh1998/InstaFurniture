Given(/^User not logged in/) do
  ENV['CUCUMBER_TESTING'] = "DISABLED"
  visit '/logout'
end

Given(/^User logged in/) do
  ENV['CUCUMBER_TESTING'] = "DISABLED"
  visit '/mock_login'
end

# https://gist.github.com/agincourt/138811
Then /^I should\s*(not)? be redirected$/ do |redirection|
  if redirection.blank?
    request.headers['HTTP_REFERER'].should_not be_nil
    request.headers['HTTP_REFERER'].should_not == request.request_uri
  else
    request.headers['HTTP_REFERER'].should be_nil
  end
end

And(/^Enable back test login bypass/) do
  ENV['CUCUMBER_TESTING'] = "ENABLED"
end
