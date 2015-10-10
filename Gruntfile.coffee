module.exports = (grunt)->
  # SDK的发布目录地址
  BUILD_PATH = '../build-4-evecalm-com-dsdsdsde'
  # path = require 'path'
  # console.log path.resolve 'assets/libs/underscore.js'
  # html = require './assets/js/tpl.js'
  # console.log html()

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
        # 清理文件夹
    clean:
      options:
        # 强制清理
        force: true
      beforebuild: 'build/'
      afterbuild: "#{BUILD_PATH}/"

    copy:
      main:
        files: [
          {
            src: [
              '**'
              '!node_modules/**'
              '!**/*.coffee'
              '!**/*.less'
              '!**/*.map'
              '!**/*.json'
              '!config.codekit'
            ]
            dest: "#{BUILD_PATH}/"
            filter: 'isFile'
            expand: true
          }
        ]
      builed:
        cwd: "#{BUILD_PATH}/"
        src: "**"
        dest: 'build/'
        filter: 'isFile'
        expand: true

    replace:
      options:
        patterns: [
          {
            # 移除css的sourcemap
            match: /\/\*[^*]+\*\/$/
            replacement: ''
          }
          {
            # 移除js的sourcemap
            match: /\/\/.+\.map$/
            replacement: ''
          }

        ]

      main:
        files: [
          {
            src: "#{BUILD_PATH}/**/*.css"
            dest: "#{BUILD_PATH}/"
          }
          {
            src: "#{BUILD_PATH}/**/*.js"
            dest: "#{BUILD_PATH}/"
          }
        ]


    htmlmin:
      options:
        removeComments: true
        collapseWhitespace: true
      file:
        files:
          src: 'build/*.html'
          dest: 'build/'
          # filter:
            # cwd: 'build/'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-replace'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-htmlmin'


  # grunt.registerTask 'default', ['htmlmin']
  grunt.registerTask 'default', ['clean:beforebuild', 'copy:main', 'replace', 'copy:builed', 'clean:afterbuild']
