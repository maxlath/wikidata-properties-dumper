Q = require 'q'
qreq = require 'qreq'
fs = require 'fs'
_ = require './utils'

# total defauts to 1500 as it's the ceil of the current number of wikidata properties
# limit is 50 as non-bot users can't request more than 50 entities at a time, ugly loop coming :/
module.exports = (language='en', total=1500, limit=50, offset=0)->
  promises = new Array
  result = new Object
  missing = new Array
  missingLang = new Array

  from = 1+offset
  to = Math.ceil(total/limit)
  [from..to].forEach (n)->
    ids = [n*limit-(limit-1)..n*limit].map (el)-> 'P' + el
    promises.push wikidataGetEntities(ids, [language])

  Q.all(promises)
  .spread ->
    Array.prototype.forEach.call arguments, (resp)->
      if resp.body.warning?
        _.logRed resp.body.warning
      if resp.body.entities?
        for k,v of resp.body.entities
          if k[0] is '-'
            missing.push v.id
          else
            if v.labels? && v.labels[language]?
              result[k] = v.labels[language].value
            else
              missingLang.push [v.id, v.labels.en.value]
              result[k] = v.labels.en.value
      return

    json = JSON.stringify {properties: result, missing: missing}, null, 4
    if offset > 0
      fs.writeFileSync "./properties-#{language}-#{from}-#{to}.json", json
    else fs.writeFileSync "./properties-#{language}.json", json

    jsonLang = JSON.stringify {language: language, missing: missingLang}, null, 4
    fs.writeFileSync "./missingLangProp-#{language}.json", jsonLang
    _.logGreen 'done!'

  .fail (err)->
    _.logRed err, 'err'
  .done()


wikidataGetEntities = (ids, languages=['en'], props=['labels'], format='json')->
  pipedIds = ids.join '|'
  languages.push 'en' unless _.has languages, 'en'
  pipedLanguages = languages.join '|'
  pipedProps = props.join '|'
  _.logBlue query = "https://www.wikidata.org/w/api.php?action=wbgetentities&languages=#{pipedLanguages}&format=#{format}&props=#{pipedProps}&ids=#{pipedIds}", 'query'
  return qreq.get(query)