wikidata-properties-dumper
==========================

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

Dumps
-------
[de](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/properties/de.json) -
[en](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/properties/en.json) -
[fr](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/properties/fr.json)

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
