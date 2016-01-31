#!/usr/bin/env coffee

breq = require 'bluereq'
get = (url)-> breq.get(url).then (res)-> res.body
Promise = require 'bluebird'
queries = require '../queries'
saveResults = require './save_results'
require 'colors'
# console.log 'queries', queries

query = (id)-> "http://quarry.wmflabs.org/run/#{id}/output/1/json"

promises = {}

for lang, queryData of queries
  { json } = queryData
  url = query json
  console.log "#{lang} data:".grey, url
  promises[lang] = get url

Promise.props promises
.then saveResults
.then -> console.log 'done!'.green
.catch (err)-> console.log 'err'.red, err.stack
