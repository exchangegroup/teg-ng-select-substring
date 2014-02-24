(function () {
  'use strict';
  angular.module('TegNgSelectSubstring', ['TegNgTextUtils']).factory('tegNgSelectSubstring', [
    'tegNgTextUtils',
    '$sce',
    function (tegNgTextUtils, $sce) {
      return {
        select: function (text, highlightText) {
          return $sce.trustAsHtml(this.selectUnsafe(text, highlightText));
        },
        selectUnsafe: function (text, highlightText) {
          var word, words, _i, _len;
          if (text == null) {
            text = '';
          }
          words = this.extractWords(highlightText);
          for (_i = 0, _len = words.length; _i < _len; _i++) {
            word = words[_i];
            text = this.replaceOneWord(text, word);
          }
          text = tegNgTextUtils.escapeHtml(text);
          text = text.replace(/__tag_start__/g, '<span class=\'SelectedSubstring\'>');
          return text.replace(/__tag_end__/g, '</span>');
        },
        extractWords: function (text) {
          var words;
          if (text == null) {
            text = '';
          }
          words = text.split(' ');
          words = words.filter(function (element) {
            return element.length;
          });
          words = this.uniqArray(words);
          return words.sort(function (a, b) {
            return a.length - b.length;
          });
        },
        replaceOneWord: function (text, word) {
          var replaceRegExp, replaceWhat, replaceWith;
          replaceWhat = tegNgTextUtils.escapeRegexp(word);
          replaceRegExp = new RegExp('\\b(' + replaceWhat + ')', 'gi');
          replaceWith = '__tag_start__$1__tag_end__';
          return text.replace(replaceRegExp, replaceWith);
        },
        uniqArray: function (array) {
          return array.filter(function (value, index, self) {
            return self.indexOf(value) === index;
          });
        }
      };
    }
  ]);
}.call(this));