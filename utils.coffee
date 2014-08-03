colors = require 'colors'

module.exports =
  log: (obj, label, color = 'white')->
    if typeof obj is 'string' && !label?
      console.log obj[color]

    else
      if label?
        console.log "****** ".grey + label[color] + " ******".grey
      else
        console.log "******************************"[color]
      console.log obj
      console.log "-----".grey

  logRed: (obj, label)-> @log obj, label, 'red'
  logGreen: (obj, label)-> @log obj, label, 'green'
  logBlue: (obj, label)-> @log obj, label, 'blue'
  logYellow: (obj, label)-> @log obj, label, 'yellow'

  has: (array, value)-> array.indexOf(value) isnt -1