setup.rb
===

年度などの初期設定をしたり，テンプレートファイルを生成するツールです．
soukai-templateからforkした直後や，各局のブランチを作るときに使ってください．

Macではreadlineをインストールする必要があるかもしれません.
[参考リンク](http://qiita.com/kidachi_/items/d0137d96bed9ac381fd5)

## assignee.ymlについて
章の担当者を管理するファイルです．
テンプレートファイルの生成やBitbucketへの課題追加時に利用されます．
フォーマットは以下のようになっています．

`filename: タイトル, 姓 名, BitbucketID`

YAMLファイルは以下のようなフォーマットで記述します．
詳しくはググってください．

```yaml
soukatsu:
  zentai:
    zentai: 後期活動総括, RCC 会長, cc
    unei: 運営総括, RCC 副会長, cc
```

例えば，全体総括の中に学園祭総括を追加したい場合は以下のように編集します．

```yaml
soukatsu:
  zentai:
    zentai: 後期活動総括, RCC 会長, bitbucket_kaicho
    unei: 運営総括, RCC 副会長, bitbucket_hukukaicho
    gakuensai: 学園祭総括, RCC 学祭担当者, bitbucket_gakuensai
```

## 各コマンドの使い方

### initコマンド
`document.tex`と`README.md`をその年に合わせて作成します．
実行すると開催年などが入力できる状態になるので，それに応じて正しい値を入力してください．

例:

```bash
$ ruby setup.rb init
$ ruby setup.rb I
```

WerckerのShare Badgeが最後に聞かれます．
Werckerで継続的インテグレーションの設定を行っている場合に利用できます．
WerckerのShare Badge (Markdown表記) は，
Werckerのアプリケーション別の設定ページから，
左メニューの「Sharing」をクリックすると見つけることができます．
Werckerをまだ使っていない場合は空欄にしておいてください．
後からでも変更ができます．

### generateコマンド
`assignee.yml`を読み込んで，subsection以降を書くためのテンプレートファイルを生成します．
それと同時に`\input`コマンドもファイルに追記します．
`assignee.yml`に正しいフォーマットで担当者の情報を記入する必要があります．

フィルターを指定して生成するファイルを制御することができます．
フィルターを利用することで局のファイルだけ生成するということが可能になります．
フィルターは以下のいずれかで指定できます．

- `filepath`
- `<type>`
- `<type> <section>`

おそらくファイルパスでディレクトリを指定するのが一番簡単でしょう．
`type`と`section`はそれぞれ以下のパラメータから選ぶことができます．

```
type:
  hajimeni
  soukatsu
  houshin

section:
  zentai
  kaikei
  kensui
  syogai
  system
  soumu
```

例:

```bash
$ ruby setup.rb generate
$ ruby setup.rb g src/soukatsu/soumu
$ ruby setup.rb g houshin
```

### issueコマンド
`assignee.yml`を読み込んで，Bitbucketに課題を登録します。
generateコマンドと同様にフィルターを指定できます．

例:

```bash
$ ruby setup.rb issue
$ ruby setup.rb i src/soukatsu/soumu
$ ruby setup.rb i houshin
```

## 局別ブランチを作る例
ここではシステム管理局を例として局別ブランチを作る方法を説明します．

まずdevelopブランチから局別ブランチを切ります．
局別ブランチは総括と方針で分けておいたほうが管理しやすいです．

```bash
$ git checkout develop
$ git checkout -b system_soukatsu
```

ブランチを作り終えたら`assignee.yml`を編集します．
システム管理局総括の章を増やします．
以下はその一部抜粋です．

```yaml
soukatsu:
  syogai:
#    zentai: 全体総括,
  system:
    zentai: 全体総括, シス管 局長, kyokucho
    torikumi: 会内の技術を高める取り組み, シス管 局員その1, kyokuin1
    service: サービスの運用, シス管 局員その2, kyokuin2
  soumu:
#    zentai: 全体総括,
```

編集が終わったらテンプレートファイルを生成しましょう．
以下のコマンドを打って生成します．
また，Bitbucketの課題にも追加しましょう

```bash
$ ruby setup.rb g src/soukatsu/system
$ ruby setup.rb i src/soukatsu/system
```

テンプレートの生成は完了したので，ブランチをpushします．

```bash
$ git push -u origin system_soukatsu
```

以上が局別ブランチの作り方でした．
局別ブランチを作って，面倒な手動マージ作業を減らしましょう！