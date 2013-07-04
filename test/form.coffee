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
      browser.fill("text_name", "Michael").select("select_name", "Wien").check("fussball").check("tennis").choose("maennlich").pressButton "submit_name", ->
        expect browser.location.pathname, "/users"
        expect(browser.text("p")).to.contain "Michael"
        expect(browser.text("p")).to.contain "Wien"
        expect(browser.text("p")).to.contain "fussball"
        expect(browser.text("p")).to.contain "tennis"
        expect(browser.text("p")).to.not.contain "golf"
        expect(browser.text("p")).to.contain "maennlich"
        expect(browser.text("p")).to.not.contain "weiblich"
        done()



