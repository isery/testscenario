module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    env : {
      options : {
       //Shared Options Hash
      },
      dev : {
        NODE_ENV : 'development',
        PORT : 3000
      },
      deploy : {
        NODE_ENV : 'production',
        PORT : 3001
      },
      test : {
        NODE_ENV : 'test',
        PORT : 3002
      }
    },
    jshint: {
      files: ['gruntfile.js', 'routes/**/*.js', 'public/javascripts/*.js', 'test/**/*.js','app.js','server.js'],
      options: {
        // options here to override JSHint defaults
        globals: {
          jQuery: true,
          console: true,
          module: true,
          document: true,
          smarttabs: true
        }
      }
    },
    karma: {
      unit: {
        configFile: 'karma.conf.js',
        singleRun:true
      }
    },
    watch: {
      files: ['<%= jshint.files %>'],
      tasks: ['jshint']
    },
    mochaTest: {
      files: ['test/acceptance/**/*.coffee', 'test/unit/**/*.coffee']
    },
    mochaTestConfig: {
      options: {
        reporter: 'nyan',
        compilers: 'coffee-script',
        timeout: '3000'        
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-env');
  grunt.loadNpmTasks('grunt-karma');

  grunt.registerTask('test', ['env:test', 'jshint', 'mochaTest', 'karma']);
  grunt.registerTask('deploy', ['env:deploy']);
  grunt.registerTask('dev', [ 'env:dev']);
  grunt.registerTask('default', [ 'env:test', 'jshint', 'mochaTest', 'karma']);

};
