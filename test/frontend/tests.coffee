expect = chai.expect;

describe 'Unit Test', ->
	it 'returns the given value', (done) -> 
		expect(returnCorrect(5)).to.equal(5)
		expect(returnCorrect(-5)).to.not.equal(5)
		done()
	it "returns the inverted value", (done) ->
		expect(returnInverted(5)).to.equal(-5)
		expect(returnInverted(5)).to.not.equal(5)
		done()