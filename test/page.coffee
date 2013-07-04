testconfig = require('./testconfig')
browser = testconfig.browser;
server = testconfig.server;
expect = testconfig.expect;

describe "Check Page ", ->
  before (done) ->
    browser.site = "localhost:" + server.get("port")
    browser.debug = true
    done()
     
  it "/", (done) ->
    browser.visit "/", ->
      expect(browser.success).to.equal true
      expect(browser.location.pathname).to.equal "/"
      expect(browser.text("title")).to.equal "Express"
      done()

  it "/", (done) ->
    browser.visit "/", ->
      browser.clickLink "users", ->
        expect(browser.success).to.equal true
        expect(browser.location.pathname).to.equal "/users"
        done()

  #chaining a test because zombie thinks 404 is an error   
  it "/", (done) ->
    browser.visit "/", ->
      browser.clickLink("foo").then( ->
        expect(browser.statusCode).to.equal 404
        done()
      ).fail( (error) ->
        expect(browser.statusCode).to.equal 404
        done()
      )

