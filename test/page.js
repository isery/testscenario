var server = require('../server'),
    Browser = require('zombie'),
    http = require('http'),
    chai = require('chai'),
    expect = chai.expect,
    Testserver = 0,
    browser = new Browser();

describe('Check Page ', function(){

    before(function(done){
        Testserver = http.createServer(server).listen(server.get('port'), function(){
          console.log("Express server listening on port " + server.get('port'));
          browser.site = 'localhost:'+server.get('port');
          done();
        });
    });

    after(function(){
        browser.close();
        Testserver.close();
    });


    it('/', function(done){
        browser.visit("/", function () {
            expect(browser.success).to.equal(true);
            expect(browser.location.pathname).to.equal('/');
            expect(browser.text("title")).to.equal('Express');
            done();
        });
    });

    it('/', function(done){
        browser.visit("/", function () {
            browser.clickLink("foo", function() {
                expect(browser.success).to.equal(false);
                expect(browser.location.pathname).to.equal('/foo');
                done(); 
            });  
        });
    });

    it('/', function(done){  
        browser.visit("/", function () {
            browser.clickLink("users", function() {
                expect(browser.success).to.equal(true);
                expect(browser.location.pathname).to.equal('/users');
                done(); 
            });  
        });  
    });

    it('/', function(done){  
        browser.visit("/", function () {
            browser.fill("text_name", "Michael").
                    select("select_name", "Wien").
                    check("fussball").
                    check("tennis").
                    choose("maennlich").
                    pressButton("submit_name", function() {
                        expect(browser.location.pathname, "/users");
                        expect(browser.text('p')).to.contain('Michael');
                        expect(browser.text('p')).to.contain('Wien');
                        expect(browser.text('p')).to.contain('fussball');
                        expect(browser.text('p')).to.contain('tennis');
                        expect(browser.text('p')).to.not.contain('golf');
                        expect(browser.text('p')).to.contain('maennlich');
                        expect(browser.text('p')).to.not.contain('weiblich');
                        done();
                    });
        });  
    });
});

