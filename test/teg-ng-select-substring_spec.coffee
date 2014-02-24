describe 'TegNgSelectSubstring helper', ->
  beforeEach -> module('TegNgSelectSubstring')
  beforeEach ->
    @mockTegTextUtils = { escapeRegexp: (text) -> text }
    @mockSce = { }

    angular.mock.module ($provide) =>
     $provide.value 'tegNgTextUtils', @mockTegTextUtils
     $provide.value '$sce', @mockSce
     null

  beforeEach(inject((@tegNgSelectSubstring) ->))

  it 'returns "html safe" highlighted text', ->
    @mockSce.trustAsHtml = jasmine.createSpy().andReturn 'trusted html'

    result = @tegNgSelectSubstring.select('Pillar is big. Oil spill', 'Big pill')

    expect(@mockSce.trustAsHtml).toHaveBeenCalledWith "<span class='SelectedSubstring'>Pill</span>ar is <span class='SelectedSubstring'>big</span>. Oil spill"
    expect(result).toBe 'trusted html'

  it 'highlights parts of words that start with "big" or "pill" in any order', ->
    result = @tegNgSelectSubstring.selectUnsafe('Pillar is big. Oil spill', 'Big pill')
    expect(result).toBe(
      "<span class='SelectedSubstring'>Pill</span>ar is <span class='SelectedSubstring'>big</span>. Oil spill")

  it 'escapes regexp', ->
    @mockTegTextUtils.escapeRegexp = (text) -> "escaped #{ text }"
    result = @tegNgSelectSubstring.selectUnsafe('Folding escaped chair', 'chaiR')
    expect(result).toBe "Folding <span class='SelectedSubstring'>escaped chair</span>"

  it 'does not replace "a" inside html entities, like &amp;', ->
    result = @tegNgSelectSubstring.selectUnsafe('Parts & Bolts', 'a')
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