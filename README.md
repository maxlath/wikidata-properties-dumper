wikidata-properties-dumper
==========================

**UPDATE**: this repository was hosting [experimentations](http://stackoverflow.com/a/25745689/3324977) at getting a list of all Wikidata properties as JSON before Wikidata SPARQL endpoint was up. Now that it's there, we can do better!

* get the full list straight from Wikidata Query ([try the query](https://query.wikidata.org/#SELECT%20%3Fproperty%20%3FpropertyLabel%20WHERE%20%7B%0A%20%20%20%20%3Fproperty%20a%20wikibase%3AProperty%20.%0A%20%20%20%20SERVICE%20wikibase%3Alabel%20%7B%0A%20%20%20%20%20%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%22%20.%0A%20%20%20%7D%0A%20%7D%0A%0ALIMIT%205), [get it as JSON](https://query.wikidata.org/sparql?format=json&query=SELECT%20%3Fproperty%20%3FpropertyLabel%20WHERE%20%7B%0A%20%20%20%20%3Fproperty%20a%20wikibase%3AProperty%20.%0A%20%20%20%20SERVICE%20wikibase%3Alabel%20%7B%0A%20%20%20%20%20%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%22%20.%0A%20%20%20%7D%0A%20%7D%0A%0A))

* or, for a pre-formatted version:
  * use the [`wd props`](https://github.com/maxlath/wikidata-cli#wd-props) command from [Wikidata CLI](https://github.com/maxlath/wikidata-cli)
  * use [that dump of `wd props --type`](https://github.com/maxlath/wikidata-edit/blob/master/lib/properties/properties.js)
  * use [Wikidata Propbrowse](https://tools.wmflabs.org/hay/propbrowse/) and its [JSON dump](https://tools.wmflabs.org/hay/propbrowse/props.json)

<hr>

There are now more than 2400 property ids on wikidata (less active ones though), but no handy standard json version of those, so I made one by hand, per language.
You can find `en`, `de`, `fr`, `es` and `it` versions already in the `./output` folder.

It looks like this:
```javascript
{
    "P6": "head of government",
    "P7": "brother",
    "P9": "sister",
    "P10": "video",
    "P14": "highway marker",
    "P15": "road map",
    "P16": "highway system",
    "P17": "country",
    "P18": "image",
    ...
```

Properties dumps
-------
* [Deutsch](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/properties/de.json)
* [English](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/properties/en.json)
* [French](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/properties/fr.json)

How To dump Properties for other languages
-------

**Options 1**

* create a new query in Quarry, copying [this one](http://quarry.wmflabs.org/query/7150) but replacing `fr` with the 2-letters language code of your choice
* copy this repo:
```bash
git clone https://github.com/maxlath/wikidata-properties-dumper.git
```
* add the query id and the json output id to the `./queries.json` file
* then run `npm start`

and you're done! JSON files are waiting for you in the `properties` folder!

**Options 2**: lazy but slower
* just ask me to add the desired language to the existing dumps :)
