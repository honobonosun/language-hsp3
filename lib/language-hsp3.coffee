callback = (err, stdout, stderr) ->
  iconv = require('iconv-lite')
  str = iconv.decode(new Buffer(stdout,'binary'),'Shift_JIS')
  if err
    option = {
      detail: "#{str}"
      dismissable: true	# 勝手に消えないようにする。
    }
    atom.notifications.addError "Error (language-hsp3)", option
  else
    option = {
      detail: "#{str}"
      dismissable: atom.config.get("language-hsp3.keepShowSuccessMessage")
    }
    atom.notifications.addSuccess "Success (language-hsp3)", option
  return

module.exports = {
  activate: (state) ->
    atom.commands.add 'atom-workspace','language-hsp3:run': => @run()
    atom.commands.add 'atom-workspace','language-hsp3:make': => @make()

  # コマンドを実行する。commands引数はutf8Encodeの値でuが足される。
  exec: (filepath,commands) ->
    if atom.config.get("language-hsp3.utf8Encode")
      commands = commands + "u"

    path = atom.config.get('language-hsp3.hspcPath')
    exec = require('child_process').execFile
    exec path,["#{commands}","#{filepath}"],{encoding  : 'Shift_JIS',maxBuffer : atom.config.get("language-hsp3.maxLogBuffer")},callback

  # editorを安全に取得しつつ、未保存なら通知する。
  getSafeEditor: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?
    return unless editor.isEmpty()?
    if editor.isModified()
      atom.notifications.addInfo "Not been saved file. (language-hsp3)",{detail: "Please save to reflect changes in buffer."}
    return editor

  # コンパイル＋実行
  run: ->
    editor = @getSafeEditor()
    return unless editor?

    filepath = editor.getPath()
    return unless filepath?

    @exec filepath,atom.config.get("language-hsp3.runOption")

  # 自動実行ファイル作成
  make: ->
    editor = @getSafeEditor()
    return unless editor?

    filepath = editor.getPath()
    return unless filepath?

    @exec filepath,atom.config.get("language-hsp3.makeOption")

  config: {
    hspcPath: {
      description: "hspc.exeのファイルパス。"
      type: "string"
      default: "C:/hsp35/hspc.exe"
    }
    utf8Encode: {
      description: "Shift-JISをUTF-8エンコード処理するフラグ。"
      type: "boolean"
      default: false
    }
    runOption: {
      description: "コンパイル＋実行のコマンド。"
      type: "string"
      default: "-Crdw"
    }
    makeOption: {
      description: "自動実行ファイル作成のコマンド。"
      type: "string"
      default: "-CPm"
    }
    maxLogBuffer: {
      description: "コンパイラの通知受取バッファサイズ(byte)  \nもし、通知内容が見切れるようでしたら、この数字を増やしてください。"
      type: "integer"
      default: 204800
      minimum: 204800
      maximum: null
    }
    keepShowSuccessMessage: {
      description: "コンパイルに成功した場合、メッセージを表示し続ける。"
      type: "boolean"
      default: true
    }
  }
}
