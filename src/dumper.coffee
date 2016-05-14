#!/usr/bin/env coffee

breq = require 'bluereq'
get = (url)-> breq.get(url).then (res)-> res.body
Promise = require 'bluebird'
queries = require '../queries'
saveResults = require './save_results'
require 'colors'
# console.log 'queries', queries

# To find the query id, look at the query page's download link
# ex: https://quarry.wmflabs.org/query/7150
query = (id, output)->
  "https://quarry.wmflabs.org/run/#{id}/output/#{output}/json"

promises = {}

for lang, queryData of queries
  { json, output } = queryData
  url = query json, output
  console.log "#{lang} data:".grey, url
  promises[lang] = get url

Promise.props promises
.then saveResults
.then -> console.log 'done!'.green
.catch (err)-> console.log 'err'.red, err.stack
