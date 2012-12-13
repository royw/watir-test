require_relative 'spec_helper'

describe 'watir setup' do
  it 'should visit watir.com' do
    @browser.goto 'http://watir.com/'
    @browser.url.should == 'http://watir.com/'
  end
end