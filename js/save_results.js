// Generated by CoffeeScript 1.10.0
(function() {
  var Promise, fs, parseResult, save, writeFile;

  fs = require('fs');

  Promise = require('bluebird');

  writeFile = Promise.promisify(fs.writeFile);

  module.exports = function(results) {
    var data, lang, promises, result;
    promises = [];
    for (lang in results) {
      result = results[lang];
      data = parseResult(lang, result);
      promises.push(save(lang, data));
    }
    return Promise.all(promises);
  };

  parseResult = function(lang, result) {
    var i, label, len, p, props, ref, row, rows;
    props = {};
    rows = result.rows;
    console.log((lang + " properties:").blue, rows.length);
    ref = rows.reverse();
    for (i = 0, len = ref.length; i < len; i++) {
      row = ref[i];
      p = row[0], label = row[1];
      props[p] = label;
    }
    return props;
  };

  save = function(lang, data) {
    var json;
    json = JSON.stringify(data, null, 2);
    return writeFile("./properties/" + lang + ".json", json);
  };

}).call(this);