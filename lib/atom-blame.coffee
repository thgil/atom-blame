HelloView = require './atom-blame-view'

module.exports =
  atomBlameView: null

  activate: (state) ->
    atom.workspaceView.command "atom-blame:toggle", => @blame()

  deactivate: ->
    @atomBlameView.destroy()

  serialize: ->
    atomBlameViewState: @atomBlameView.serialize()

  blame: ->
    # comment
    # editor = atom.workspace.activePaneItem
    # editor.insertText("Hello, world")
    # atomBlameView = new HelloView(greeting: "Hi there")
    atom.workspaceView.find('.editor').append(new HelloView(greeting: "Hi there"))

    git = atom.project.getRepo()
    console.log git.getOriginUrl()
