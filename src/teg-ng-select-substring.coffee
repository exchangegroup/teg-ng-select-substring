"use strict"

angular.module('TegNgSelectSubstring', ['TegNgTextUtils']).
factory('tegNgSelectSubstring', (tegNgTextUtils, $sce) ->
  select: (text, highlightText) ->
    $sce.trustAsHtml(@selectUnsafe(text, highlightText))

  selectUnsafe: (text, highlightText) ->
    words = @extractWords(highlightText)
    text = @replaceOneWord(text, word) for word in words

    text = @escapeHtml(text)
    text = text.replace(/__tag_start__/g, "<span class='SelectedSubstring'>")
    text.replace(/__tag_end__/g, '</span>')

  extractWords: (text) ->
    words = text.split(' ')
    words = words.filter((element) -> element.length)
    words = @uniqArray(words)
    words.sort((a, b) -> a.length - b.length)

  replaceOneWord: (text, word) ->
    replaceWhat = tegNgTextUtils.escapeRegexp(word)
    replaceRegExp = new RegExp("\\b(#{replaceWhat})", 'gi')
    replaceWith = "__tag_start__$1__tag_end__"
    text.replace(replaceRegExp, replaceWith)

  uniqArray: (array) ->
    array.filter (value, index, self) ->
      self.indexOf(value) == index

  escapeHtml: (unsafe) ->
    unsafe
     .replace(/&/g, "&amp;")
     .replace(/</g, "&lt;")
     .replace(/>/g, "&gt;")
     .replace(/"/g, "&quot;")
     .replace(/'/g, "&#039;");
)