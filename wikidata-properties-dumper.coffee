#!/usr/bin/env coffee

# MUST be passed as argument: lang
# MAY be passed as arguments: total, offset

[ language, total, offset ]  = process.argv.slice(2)

# total defauts to 1700 as it's the ceil of the current number of wikidata properties
total or= 1700

# limit is 50 as non-bot users can't request more than 50 entities at a time, ugly loop coming :/
limit = 50

offset or= 0

Q = require 'q'
qreq = require 'qreq'
fs = require 'fs'
_ = require './utils'

dumpProperties = ->
  requests = buildBatchRequests()
  _.log requests, 'requests'
  Q.all(requests)
  .fail (err)-> _.logRed err, 'err buildBatchRequests'
  .spread parseWikidataResponses
  .fail (err)-> _.logRed err, 'err parseWikidataResponses'
  .then writeOutputs
  .fail (err)-> _.logRed err, 'err parseWikidataResponses'

parseWikidataResponses = (args...)->
  result = {}
  missing = []
  missingLang = []

  args.forEach (resp)->
    if resp.body.warning? then _.logRed resp.body.warning
    if resp.body.entities?
      for id, entity of resp.body.entities
        if id[0] is '-' then missing.push entity.id
        else
          if entity.labels? and entity.labels?[language]?
            result[id] = entity.labels[language].value
          else
            enProp = entity.labels?.en.value
            if enProp?
              missingLang.push [entity.id, enProp]
              result[id] = enProp
            else
              missing.push entity.id

  return [result, missing, missingLang]

buildBatchRequests = ->
  requests = []
  from = 1+offset
  to = Math.ceil(total/limit)
  [from..to].forEach (n)->
    ids = [n*limit-(limit-1)..n*limit].map (el)-> 'P' + el
    requests.push wikidataGetEntities(ids)

  return requests

wikidataGetEntities = (ids, props=['labels'], format='json')->
  languages = ['en']
  unless language is 'en' then languages.push language
  pipedIds = ids.join '|'
  pipedLanguages = languages.join '|'
  pipedProps = props.join '|'
  _.logBlue query = "https://www.wikidata.org/w/api.php?action=wbgetentities&languages=#{pipedLanguages}&format=#{format}&props=#{pipedProps}&ids=#{pipedIds}", 'query'
  return qreq.get(query)


writeOutputs = (outputs)->
  [result, missing, missingLang] = outputs
  writeProps(result, missing)
  writeMissingLangProp(missingLang)

writeProps = (result, missing)->
  _.log result, 'result'
  _.log missing, 'missing'
  json = JSON.stringify {properties: result, missing: missing}, null, 4
  if offset > 0
    fs.writeFileSync "./properties-#{language}-#{from}-#{to}.json", json
  else fs.writeFileSync "./outputs/properties-#{language}.json", json

writeMissingLangProp = (missingLang)->
  _.log missingLang, 'missingLang'
  jsonLang = JSON.stringify {language: language, missing: missingLang}, null, 4
  fs.writeFileSync "./outputs/missingLangProp-#{language}.json", jsonLang
  _.logGreen 'done!'


dumpProperties()