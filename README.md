wikidata-properties-dumper
==========================

When I request wikidata entities, I always struggle with those obscure properties identifiers and was looking for a flat index mapping those as such: {PropertyId: Label}
and not a deep object I would have to 1/request 2/parse.
It's quite likely something already exist to address this concern but I couldn't find it so here is my version :)

This small tool requests all wikidata 'Properties' and outputs an index of those properties with a simple label in a given language + a list of currently missing labels in this language.
You can find en, de, and fr versions already in the output folders.

Outputs are json files as there should be a way around firing 1500 entities request to wikidata API everytime you start your program


How To dump Properties for other languages
-------
```
git clone git@github.com:maxlath/wikidata-properties-dumper.git
npm install
```

then open a coffeescript REPL session

`coffee`

require the main file
```
dumper = require './wikidata-properties-dumper'
```

execute the function with the code of your language of choice
```
dumper 'fr'
```

and your done! JSON files are waiting for you in the `output` folder

