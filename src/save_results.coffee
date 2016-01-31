fs = require 'fs'
Promise = require 'bluebird'
writeFile = Promise.promisify fs.writeFile

module.exports = (results)->
  promises = []

  for lang, result of results
    data = parseResult lang, result
    promises.push save(lang, data)

  Promise.all promises


parseResult = (lang, result)->
  props = {}
  { rows } = result

  console.log "#{lang} properties:".blue, rows.length
  # reverse is required to make the final output appear in ascending order
  for row in rows.reverse()
    [ p, label ] = row
    props[p] = label


  return props

save = (lang, data)->
  json = JSON.stringify data, null, 2
  return writeFile "./properties/#{lang}.json", json
