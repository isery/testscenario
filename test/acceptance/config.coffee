exports.server = server = require("../../server")
exports.app = require("../../app")
exports.Browser = require("zombie")
exports.chai = require("chai")
exports.expect = exports.chai.expect
exports.browser = browser = new exports.Browser({debug:false})

before (done) ->
	browser.site = "localhost:" + server.get("port")
	done()
after (done) ->
	browser.close()
	done()