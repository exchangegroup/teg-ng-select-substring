describe 'TegNgSelectSubstring helper', ->
  beforeEach -> module('TegNgSelectSubstring')
  beforeEach ->
    @mockTegRegexp = { escape: (text) -> text }

    angular.mock.module ($provide) =>
     $provide.value 'tegNgRegexpUtils', @mockTegRegexp
     null

  beforeEach(inject((@tegNgSelectSubstring) ->))

  it 'highlights parts of words that start with "big" or "pill" in any order', ->
    result = @tegNgSelectSubstring.select('Pillar is big. Oil spill', 'Big pill')
    expect(result).toBe(
      "<span class='SelectedSubstring'>Pill</span>ar is <span class='SelectedSubstring'>big</span>. Oil spill")

  it 'escapes regexp', ->
    @mockTegRegexp.escape = (text) -> "escaped #{ text }"
    result = @tegNgSelectSubstring.select('Folding escaped chair', 'chaiR')
    expect(result).toBe "Folding <span class='SelectedSubstring'>escaped chair</span>"

  it 'does not replace "a" inside html entities, like &amp;', ->
    result = @tegNgSelectSubstring.select('Parts & Bolts', 'a')
    expect(result).toBe "Parts &amp; Bolts"

  describe 'extracts words from text', ->
    it 'ordered by length without duplicates', ->
      result = @tegNgSelectSubstring.extractWords('caterpillar pi   pillar pill cat pill')
      expect(result).toEqual [
        'pi'
        'cat'
        'pill'
        'pillar'
        'caterpillar'
      ]

  describe 'replaces word with special text', ->
    it '', ->
      result = @tegNgSelectSubstring.replaceOneWord('decat caterpillar', 'cat')
      expect(result).toBe 'decat __tag_start__cat__tag_end__erpillar'