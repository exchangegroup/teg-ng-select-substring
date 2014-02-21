angular.module('TegNgSelectSubstring', ['TegRegexp']).
factory('tegNgSelectSubstring', ['tegRegexp', (tegRegexp) ->
  select: (text, highlightText) ->
    words = @extractWords(highlightText)
    text = @replaceOneWord(text, word) for word in words

    text = _.escape(text)
    text = text.replace(/__tag_start__/g, "<span class='SelectedSubstring'>")
    text.replace(/__tag_end__/g, '</span>')

  extractWords: (text) ->
    words = text.split(' ')
    words = _.filter(words, 'length')
    words = _.uniq(words)
    _.sortBy(words, 'length')

  replaceOneWord: (text, word) ->
    replaceWhat = tegRegexp.escape(word)
    replaceRegExp = new RegExp("\\b(#{replaceWhat})", 'gi')
    replaceWith = "__tag_start__$1__tag_end__"
    text.replace(replaceRegExp, replaceWith)
])