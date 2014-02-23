describe 'TegNgSelectSubstring helper', ->
  beforeEach -> module('TegNgSelectSubstring')
  beforeEach ->
    @mockTegRegexp = { escape: (text) -> text }

    angular.mock.module ($provide) =>
     $provide.value 'tegRegexp', @mockTegRegexp
     null

  beforeEach(inject((@tegNgSelectSubstring) ->))

  it 'highlights a part in the string', ->
    result = @tegNgSelectSubstring.select('Folding chairs', 'chaiR')
    expect(result).toBe "Folding <span class='SelectedSubstring'>chair</span>s"

  it 'escapes regexp', ->
    @mockTegRegexp.escape = (text) -> "escaped #{ text }"
    result = @tegNgSelectSubstring.select('Folding escaped chair', 'chaiR')
    expect(result).toBe "Folding <span class='SelectedSubstring'>escaped chair</span>"

  it 'does not replace "a" inside html entities, like &amp;', ->
    result = @tegNgSelectSubstring.select('Parts & Bolts', 'a')
    expect(result).toBe "Parts &amp; Bolts"