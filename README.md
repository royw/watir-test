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
* Opera 12.11

## Notes

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
