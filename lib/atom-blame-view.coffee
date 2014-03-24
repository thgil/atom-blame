{ScrollView} = require 'atom'

module.exports =
class BlameView extends ScrollView
  @content: ->
    @div class: 'atom-blame', =>
      @h1 'Atom Blame'
      @pre class: 'output'

  constructor: (title) ->
    super
    @_output = @find('.output')

  append: (text, className) ->
    span = document.createElement('span')
    node = document.createTextNode(text)
    span.appendChild(node)
    # span.className = className || 'stdout'
    @_output.append(span)
