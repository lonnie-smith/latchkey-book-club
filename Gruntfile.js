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
      compiled: ['**/.DS_Store', '**/Thumbs.db', 'app/_compiled/**'],
      buildPre: ['./build/**']
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
      }
    },
    copy: {
      buildLibs: {
        expand: true,
        src: [
          './bower_components/**',
        ],
        dest: 'build'
      },
      buildAssets: {
        expand: true,
        cwd: './app',
        src: [
          './fonts/**',
          './img/**'
        ],
        dest: 'build'
      }
    },
    uglify: {
      build: {
        files: {
          'build/assets/compiled/latchkey.min.js': [
            'bower_components/angular/angular.js',
            'bower_components/angular-route/angular-route.js',
            'app/_compiled/app-module.js',
            'app/_compiled/app-config.js',
            'app/_compiled/**/*.js',
          ]
        }
      }
    },
    cssmin: {
      build: {
        files: {
          'build/assets/compiled/latchkey.min.css': ['app/_compiled/**/*.css']
        }
      }
    },
    processhtml: {
      options: {

      },
      build: {
        files: {
          'build/index.html': ['app/index.html']
        }
      }
    },
    inline_angular_templates: {
      build: {
        options: {
          base: 'app/'
        },
        files: {
          'build/index.html': [
            './app/layout/**/*.html',
            './app/meetings/**/*.html',
            './app/recos/**/*.html',
            './app/services/**/*.html'
          ]
        }
      }
    },
    shell: {
      nukeProduction: {
        command: "ssh alchemist@supernumerary.org 'rm -rf /var/www/latchkeybook.club/public'"
      },
      copyProduction: {
        command: "scp -r ./build alchemist@supernumerary.org:/var/www/latchkeybook.club/public"
      }
    }
  });

  grunt.loadNpmTasks("grunt-contrib-connect");
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks("grunt-contrib-coffee");
  grunt.loadNpmTasks("grunt-contrib-sass");
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-inline-angular-templates');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-processhtml');
  grunt.loadNpmTasks('grunt-shell');

  grunt.registerTask('build', [
    'clean:compiled',
    'clean:buildPre',
    'coffee:src',
    'sass:src',
    'copy:buildLibs',
    'copy:buildAssets',
    'uglify:build',
    'cssmin:build',
    'processhtml:build',
    'inline_angular_templates:build'
  ]);

  grunt.registerTask('deployProduction', [
    'shell:nukeProduction',
    'shell:copyProduction'
  ])

}