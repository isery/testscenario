testconfig = require('./config')
browser = testconfig.browser;
server = testconfig.server;
expect = testconfig.expect;

describe "Check Page ", ->

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