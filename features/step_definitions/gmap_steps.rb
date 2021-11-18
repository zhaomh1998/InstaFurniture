Then(/^I should see a map on the webpage/) do
  parent = page.find('div#main')
  expect(parent). to have_css("#map", visible:false)
  expect(page.has_css?('#map', visible: false)).to eq true
end

Then(/^I should see different markers on the webpage/) do
    expect(JSON.load(page.body.match(/<script>\s+var items = (\[.*\])/).captures[0])) != nil
end
