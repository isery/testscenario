server = require("../server")
Browser = require("zombie")
http = require("http")
chai = require("chai")
expect = chai.expect
Testserver = 0
browser = new Browser()
describe "Check Page ", ->
  before (done) ->
    Testserver = http.createServer(server).listen(server.get("port"), ->
      console.log "Express server listening on port " + server.get("port")
      browser.site = "localhost:" + server.get("port")
      browser.debug = true
      done()
    )

  after ->
    browser.close()
    Testserver.close()
  
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
