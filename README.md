watir-test
==========

Trying watir

## Environment

* Mac OSX 10.8.2
* Homebrew 0.9.3
* Bundler 1.2.3
* RVM 1.17.0
  * ruby 1.9.3
* Git 1.8.0
* Safari 6.0.2
* Firefox 17.0.1
* Chrome 22.0.1229.94
* Opera 11.62

## Notes

Note, latest watir supported version of Opera is 11.62.

Instead of manually installing chromedriver per the documentation, use brew:

```bash
brew install chromedriver
```

Same for selenium-server-standalone for opera:

```bash
brew install selenium-server-standalone
```

then add to ~/.exports

```bash
export SELENIUM_SERVER_JAR=/usr/local/opt/selenium-server-standalone/selenium-server-standalone-2.25.0.jar
```

## Prerequisites

You must have a .credentials file in the spec directory.
The contents of the .credentials file must be:

```
name=me
email=you@example.org
password=sekret
```

Naturally use your credentials instead of these.
Leading and trailing whitespaces are ignored as are whitespaces around the equal sign.

You should not add the .credentials file to your version control.

You should make it read-only for yourself (chmod 400 .credentials)

Lines starting with a '#' are ignored


## Usage

rake spec

### Examples

```bash
00:43:28 roy@Roy MBP:~/Projects/github/mine/watir-test (git:master-+*:bff28a6)  ruby-1.9.3-p327@watir-test
➤ WATIR_BROWSER=ff rake spec
/Users/roy/.rvm/rubies/ruby-1.9.3-p327/bin/ruby -S rspec spec/network_resource_spec.rb -c -f progress
.....

Finished in 39.75 seconds
5 examples, 0 failures
00:45:18 roy@Roy MBP:~/Projects/github/mine/watir-test (git:master-+*:bff28a6)  ruby-1.9.3-p327@watir-test
➤ WATIR_BROWSER=chrome rake spec
/Users/roy/.rvm/rubies/ruby-1.9.3-p327/bin/ruby -S rspec spec/network_resource_spec.rb -c -f progress
.....

Finished in 35.27 seconds
5 examples, 0 failures
00:45:59 roy@Roy MBP:~/Projects/github/mine/watir-test (git:master-+*:bff28a6)  ruby-1.9.3-p327@watir-test
➤ WATIR_BROWSER=opera rake spec
/Users/roy/.rvm/rubies/ruby-1.9.3-p327/bin/ruby -S rspec spec/network_resource_spec.rb -c -f progress
.....

Finished in 54.22 seconds
5 examples, 0 failures
```
