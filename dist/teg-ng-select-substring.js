(function() {
  angular.module('TegNgSelectSubstring', ['TegRegexp']).factory('tegNgSelectSubstring', [
    'tegRegexp', function(tegRegexp) {
      return {
        select: function(text, highlightText) {
          var word, words, _i, _len;
          words = this.extractWords(highlightText);
          for (_i = 0, _len = words.length; _i < _len; _i++) {
            word = words[_i];
            text = this.replaceOneWord(text, word);
          }
          text = _.escape(text);
          text = text.replace(/__tag_start__/g, "<span class='SelectedSubstring'>");
          return text.replace(/__tag_end__/g, '</span>');
        },
        extractWords: function(text) {
          var words;
          words = text.split(' ');
          words = _.filter(words, 'length');
          words = _.uniq(words);
          return _.sortBy(words, 'length');
        },
        replaceOneWord: function(text, word) {
          var replaceRegExp, replaceWhat, replaceWith;
          replaceWhat = tegRegexp.escape(word);
          replaceRegExp = new RegExp("\\b(" + replaceWhat + ")", 'gi');
          replaceWith = "__tag_start__$1__tag_end__";
          return text.replace(replaceRegExp, replaceWith);
        }
      };
    }
  ]);

}).call(this);
