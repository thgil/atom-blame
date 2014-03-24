{View} = require 'atom'

module.exports =
class HelloView extends View
  @content: (params) ->
    @div =>
      @div params.greeting
      @label for: 'name', "What is your name? "
      @div =>
        @input name: 'name', outlet: 'name'
        @button click: 'sayHello', "That's My Name"
      @br
      @div outlet: "personalGreeting"

  initialize: (params) ->
    @greeting = params.greeting

  sayHello: ->
    @personalGreeting.html("#{@greeting}, #{@name.val()}")
