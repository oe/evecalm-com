
if location.hostname isnt 'evecalm.com'
  location.href = 'http://evecalm.com'

if 'ontouchstart' of window
  document.documentElement.className += ' touch-device'
