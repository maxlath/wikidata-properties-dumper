wikidata-properties-dumper
==========================

There are now more than 2000 property ids on wikidata (less active ones though), but no handy standard json version of those, so I made one by hand, per language.
You can find `en`, `de`, `fr`, `es` and `it` versions already in the `./output` folder.

It looks like this:
```javascript
{
    "properties": {
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

Properties:
[ar](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-ar.json) -
[da](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-da.json) -
[de](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-de.json) -
[en](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-en.json) -
[es](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-es.json) -
[fr](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-fr.json) -
[it](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-it.json) -
[ja](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-ja.json) -
[nl](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-nl.json) -
[pt](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-pt.json) -
[ru](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-ru.json) -
[se](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-se.json) -
[zh](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/properties-zh.json)


Missing properties:
[ar](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-ar.json) -
[da](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-da.json) -
[de](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-de.json) -
[en](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-en.json) -
[es](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-es.json) -
[fr](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-fr.json) -
[it](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-it.json) -
[ja](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-ja.json) -
[nl](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-nl.json) -
[pt](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-pt.json) -
[ru](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-ru.json) -
[se](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-se.json) -
[zh](https://raw.githubusercontent.com/maxlath/wikidata-properties-dumper/master/outputs/missingLangProp-zh.json)

How To dump Properties for other languages
-------
```bash
git clone git@github.com:maxlath/wikidata-properties-dumper.git
npm install
```

then just execute the script with the wished 2 letter language code as first argument (e.g. here `fr` for French):

```bash
node ./wikidata-properties-dumper.js fr
```

and you're done! JSON files are waiting for you in the `output` folder:
* Properties with a label in this language, get this label
* Properties without a label in this language, get the `'en'` label and are added to the associated MissLangProp json file: yep, that's your to-complete-list


Future
-------
To get this list of properties, the script makes `number_of_properties / 50` requests to Wikidata API, which is kind of ugly: there should be a better one-(SQL?)query way to get this result. See [the related discussion on Wikidata](http://www.wikidata.org/wiki/Wikidata:Project_chat/Archive/2014/12#wikidata_properties_listed_in_a_JSON_file_as_key-values) for inspiration and send your PR if you can figure that out! :)

