colors     = require 'colors'

options =
  silly:   'rainbow'
  input:   'grey'
  verbose: 'cyan'
  prompt:  'grey'
  info:    'green'
  data:    'grey'
  help:    'cyan'
  warn:    'yellow'
  debug:   'blue'
  error:   'red'

colors.setTheme options

module.exports.basename = basename = (filename) ->
  path.basename filename, '.coffee'

module.exports.fetchFiles = fetchFiles = (folder, ext = 'coffee') ->
  basedir = if folder[0] is '/'
      folder
    else if module.parent?
      path.dirname(module.parent.filename)+'/'+folder
    else __dirname+'/'+folder

  files = findit.sync basedir
  if ext
    files.filter (f) -> f.indexOf(".#{ext}") > 0
  else files
