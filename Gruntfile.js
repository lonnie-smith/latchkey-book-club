module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    connect: {
      main: {
        options: {
          // protocol: 'https',
          port: 8080,
          base: './',
          keepalive: true,
          open: false,
          debug: true,
          livereload: 35730
        }
      },
    },
    clean: {
      compiled: ['**/.DS_Store', '**/Thumbs.db', 'app/_compiled/**']
    },
    coffee: {
      src: {
        files: [
          { expand: true,
            cwd: './app',
            src: '**/*.coffee',
            dest: './app/_compiled',
            ext: '.js'
          }
        ],
        options: {sourceMap: true}
      }
    },
    sass: {
      src: {
        files: [
          { expand: true,
            cwd: './app',
            src: ['**/*.sass'],
            dest: './app/_compiled',
            ext: '.css'
          }
        ],
        options: {
          sourcemap: 'auto'
        }
      }
    },
    watch: {
      coffee: {
        files: ['./app/**/*.coffee'],
        tasks: ['coffee:src']
      },
      sass: {
        files: ['./app/**/*.sass'],
        tasks: ['sass:src']
      },
      reload: {
        files: ['./app/**/*.js', './app/**/*.css', './app/**/*.html'],
        tasks: [],
        options: { livereload: 35730 }
      },
    }
  });

  grunt.loadNpmTasks("grunt-contrib-connect");
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks("grunt-contrib-coffee");
  grunt.loadNpmTasks("grunt-contrib-sass");
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');

}