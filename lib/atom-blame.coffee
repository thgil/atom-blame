BlameView = require './atom-blame-view'

spawn = require('child_process').spawn

module.exports =

  activate: ->
    @blameView = null
    atom.workspaceView.command "atom-blame:run", => @run()

  deactivate: ->
    @blameView.destroy()

  run: ->
    if not @blameView? or atom.workspaceView.find('.atom-blame').size() == 0
      @blameView = new BlameView
    atom.workspaceView.find('.editor').append(@blameView)

    @blame()

  blame: ->
    editor = atom.workspace.getActiveEditor()
    return unless editor?

    path = editor.getPath()

    cmd = 'git blame'
    args = [path]

    @child = spawn('git', ['blame', path, '-p'], cwd: atom.project.path )

    @child.stdout.on 'data', (data) =>
      @blameView.append(data, 'stdout')
      @blameView.scrollToBottom()
      console.log('stdout: ' + data)

    @child.stderr.on 'data', (data) =>
      @blameView.append(data, 'stderr')
      console.log('stderr: ' + data)

    @child.on 'close', (code, signal) =>
      @child = null

    unless editor.getPath()?
      @child.stdin.write(editor.getText())
    @child.stdin.end()
