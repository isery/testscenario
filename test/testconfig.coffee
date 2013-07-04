exports.server = require("../server")
exports.app = require("../app")
exports.Browser = require("zombie")
exports.chai = require("chai")
exports.expect = exports.chai.expect
exports.browser = new exports.Browser()