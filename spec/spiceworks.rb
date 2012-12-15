# Helper methods for using watir on the Spiceworks community website
module Spiceworks

  COMMUNITY_URL = 'http://community.spiceworks.com/'
  CREDENTIAL_FILENAME = File.expand_path('.credentials', File.dirname(__FILE__))
  CREDENTIALS_ERRMSG = <<-END_MISSING

You must have a .credentials file in the #{File.dirname(__FILE__)} directory.
The contents of the .credentials file must be:

name=me
email=you@example.org
password=sekret

Naturally use your credentials instead of these.
Leading and trailing whitespaces are ignored as are whitespaces around the equal sign.

You should not add the .credentials file to your version control.

You should make it read-only for yourself (chmod 400 .credentials)

Lines starting with a '#' are ignored
  END_MISSING

  module ClassMethods

    # get the website credentials
    # @return [Array<String,String,String>] returns [name,email,password]. May return nil for unknown values.
    def credentials
      name = nil
      email = nil
      password = nil
      begin
        IO.readlines(CREDENTIAL_FILENAME).each do |line|
          name = $1 if line.strip =~ /name\s*=\s*(\S+)/i
          email = $1 if line.strip =~ /email\s*=\s*(\S+)/i
          password = $1 if line.strip =~ /password\s*=\s*(\S+)/i
        end
        raise "missing name in .credentials file" if name.nil?
        raise "missing email in .credentials file" if email.nil?
        raise "missing password in .credentials file" if password.nil?
      rescue Exception => ex
        puts ex.to_s
        puts CREDENTIALS_ERRMSG
        abort 'Prerequisites not met'
      end
      [name, email, password]
    end

    # attempt a block that raises an Exception on error up to the given number of times.
    # @param [Fixnum] times the maximum number of times to try the block
    # @param [Proc] block the block to call.
    # @raise []Exception]
    # @return [Object] whatever the block returns
    def attempt(times, &block)
      n = times
      result = nil
      begin
        result = block.call(self) unless block.nil?
      rescue Exception => ex
        times -= 1
        retry if times >= 0
        raise ex
      end
      result
    end

    def scroll_right(browser, elem)
      count = 10
      while(!elem.visible? && count > 0)
        browser.send_keys :right
        count -= 1
      end
    end

    # logon to the community website
    # @param [Watir::Browser] browser the watir browser instance to use
    # @param [Array<String,String,String>] creds the credentials as [name,email,password]
    def logon(browser, creds=credentials)
      name, email, password = creds
      browser.goto COMMUNITY_URL
      browser.url.should == COMMUNITY_URL

      # note, mac ff needs a couple of attempts to scroll view to Login
      login_elem = browser.link(:text, 'Login')
      scroll_right browser, login_elem
      attempt(3) { login_elem.hover }
      attempt(3) { login_elem.click }

      email_xpath = '//*[@id="login_form"]//*[@id="email"]'
      password_xpath = '//*[@id="login_form"]//*[@id="password"]'

      browser.text_field(:xpath, email_xpath).when_present.set email
      browser.text_field(:xpath, password_xpath).set password
      browser.button(:name, 'login').click
    end

    # logoff to the community website
    # @param [Watir::Browser] browser the watir browser instance to use
    def logoff(browser)
      name, email, password = credentials

      # note, mac ff needs a couple of attempts to scroll view to Login
      name_elem = browser.link(:text, name)
      scroll_right browser, name_elem
      0.upto(3).each { name_elem.hover rescue nil }

      logout_elem = browser.link(:xpath, '//div[@data-nav="account"]/a[@href="/logout"]')
      scroll_right browser, logout_elem
      logout_elem.click
    end
  end

  extend ClassMethods

  # @param [Class] klass
  def self.included(klass)
    klass.extend self
  end
end