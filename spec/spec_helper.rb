require 'rspec'
require 'yell'
require 'pry'

RSpec.configure do |config|
  config.before(:all) do
    @logger = Yell.new STDOUT
    ENV['WATIR_BROWSER'] ||= 'ff'
    @browser =
    case ENV['WATIR_BROWSER'].downcase
      when 'ff'
       require 'watir-webdriver'
       Watir::Browser.new :ff
      when 'chrome'
       require 'watir-webdriver'
       Watir::Browser.new :chrome
      when 'opera'
       require 'watir-webdriver'
       Watir::Browser.new :opera
      when 'safari'
       require 'safariwatir'
       Watir::Safari.new
    end
  end

  config.after(:all) do
    @browser.close unless @browser.nil?
    @browser = nil
  end
end
