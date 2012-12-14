require_relative 'spec_helper'

# Create an automation script in watir-webdriver or Capybara that:
# 1. Logs you into the community.
# 2. Make the script click on Networking in the community navigation.
# 3. Verify that ‘Cisco' appears in the ‘Groups’ section exists (this group is toward the center/right side of the page)
# 4. Verify that the Resources header exists
# 5. Verify the Whitepaper icon exists next to "Seven Habits of Highly Successful MSPs".
# 6. Verify the text for "Seven Habits of Highly Successful MSPs" exists.

require_relative 'spiceworks.rb'

describe 'Check elements on Network page' do

  before :all do
    Spiceworks.logon @browser
  end

  after :all do
    Spiceworks.logoff @browser
  end

  it 'should navigate to the "Networking" page' do
    @browser.link(:xpath, '//ul[@class="channel-list"]/li/a[@href="/networking"]').when_present.click
  end

  it 'should verify "Cisco" exists in the "Groups" section' do
    elem = @browser.link(:href => 'http://www.spiceworks.com/cisco')
    elem.exist?.should be_true
    elem.visible?.should be_true
  end

  it 'should verify the "Resources" header exists' do
    @browser.h3(:text => 'Resources').exist?.should be_true
  end


  # /html/body/div[3]/div/div/section/div/div[5]/div/ul/li[3]/
  it 'should verify the "Whitepaper" icon exists next to "Seven Habits of Highly Successful MSPs"' do
    image_xpath = '//div[@class="component"]/a[contains(.,"Seven Habits of Highly Successful MSPs")]/../img'
    @browser.image(:xpath => image_xpath).exist?.should be_true
  end

  it 'should verify the text exists for "Seven Habits of Highly Successful MSPs"' do
    @browser.link(:text => "Seven Habits of Highly Successful MSPs").exist?.should be_true
  end

end