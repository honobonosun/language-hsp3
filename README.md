# language-hsp3
このパッケージは、HSP3言語の文法をサポートするための機能を含んでいます。  
HSP3 language support for Atom

<img src="https://raw.githubusercontent.com/honobonosun/language-hsp3/master/ss.png" alt="ss" title="ss">

## パッケージの導入方法
1. apmを使用する場合、以下のコマンドを実行してください。
  ```
  apm install language-hsp3
  ```
  もしくは、設定画面のインストールタブで「language-hsp3」を検索して、インストールします。

2. HSP3ソースファイルをコンパイルするための **コンソールコンパイラ** を別途、インストールする必要があります。
  - language-hsp3 は [hspc](http://dev.onionsoft.net/seed/info.ax?id=1392) を既定ツールとして、対応しています。
  - その他のツールは、完全な互換性がない事にご承知上、ご利用くださいますようお願い申し上げます。

3. コンソールコンパイラをインストールしたパスを設定してください。
  - HSP3.5を既定のフォルダ（ディレクトリ）にインストールして、hspcをreadmeに従って、HSP3.5にインストールした場合、設定は不要です。
  - 上記に当てはまらない場合
    1. コンソールコンパイラのパスを「Compiler Settings」の「Compiler path」に設定してください。
    2. 「Compile Command Settings」の各コマンド引数に、`F5`と`Ctrl-F9`が、該当するコマンド引数を設定してください。

4. 以下のコードをhello.hspとしてファイル保存後、F5キーを押してSuccess通知が表示されれば完了です。
  ```hello.hsp
  end
  ```

## 機能
HSP3開発環境をAtomで提供するために、以下の機能をサポートします。

- HSP3言語の色分け
- HDL形式ドキュメントのサポート
  - ドキュメント付けされたヘッダファイルのサポート
- 外部コンソールツールを使用したコマンド実行
  1. コンパイル＋実行(`F5`)
  2. 自動実行ファイル作成(`Ctrl-F9`)
- UTF-8の対応

### HSP3言語の色分け
HSPファイル(\*\*.hsp, \*\*.as)に対して、色分け機能を提供します。

mesなどの標準機能のキーワードはもちろん、#defineの特殊文字なども色分けされます。
また、一部コンパイルできないコードを強調表示します。

### HDL形式ドキュメントのサポート
HSP Document Library で使用する、HSファイル（バージョン2.0）の色分けとスニペットに対応しています。

%sampleフィールドタグでは、HSP3言語で色分けされます。
%instフィールドタグで**html{～}html**を使用したブロックは、HTMLで色分けされます。

#### ドキュメント付けされたヘッダファイルのサポート
HSPファイル内の複数行コメントでも、HSファイルと同じ色分け機能を提供します。

### 実行可能なコマンド
エディタの言語モードが、HSP3の場合、以下のショートカットキーが有効になります。

|key map|command|実行内容|
|------:|:-----------------|------------------|
|F5     |language-hsp3:run |コンパイル＋実行    |
|Ctrl-F9|language-hsp3:make|自動実行ファイル作成|

`F5`で「コンパイル＋実行」コマンドを実行します。
`F9-Ctrl`で「自動実行ファイル作成」コマンドを実行します。

その他に、メニューバーもしくはエディタのコンテクストメニューからコマンドを実行できます。

（更新：バージョン 0.1.0 以降）
~~今後のアップデートに対応できるように、hspcの各コマンド文字列をパッケージのSettingsから変更できます。~~

hspc以外のツールが、使用できるようになりました。
コマンドの変更は、引き続きパッケージの設定画面がら行えます。

### UTF-8の対応
（更新：バージョン 0.1.0 以降）
~~もし、あなたがShift_JISで書かれたソースコードをUTF-8環境ランタイムで動作させたい場合、パッケージのSettingsからutf8Encodeフラグを立ててください。~~

~~HSP3コンパイラ(hspcmp.dll)がソースコードをShift_JISであると仮定して、axファイル内の文字列をUTF-8で出力します。~~

この設定項目は、削除されました。

代替方法は、パッケージの設定「Compile Command Settings」を直接変更します。
`-u`オプションを追加してください。

### flex-tool-bar 設定例

以下のコードは、エディタの言語モードがHSP3の場合のみ "実行" コマンドを行うボタンを表示する設定です。

```cson
{
  type: "button"
  tooltip: "HSP3 Compile and Run"
  icon: "triangle-right"
  callback: "language-hsp3:run"
  show:
    grammar: "HSP3"
  style:
    color: "green"
}
```

## 使用したコードとライセンス表記
### language-hsp3
MIT License  
Copyright (c) 2017-2018 Honobono

### iconv-lite
MIT License  
<https://www.npmjs.com/package/iconv-lite>

Copyright (c) 2011 Alexander Shtuchkin

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
