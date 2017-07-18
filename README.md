[![Build Status](https://travis-ci.org/JunichiIto/train-ticket-rails.svg?branch=master)](https://travis-ci.org/JunichiIto/train-ticket-rails)

# TrainTicketRails

Sample application for [Rails Developers Meetup #4](https://rails-developers-meetup.connpass.com/).

電車の改札口を簡易的にシミュレーションするRailsアプリケーションです。

## アプリケーションの概要

切符を購入して乗車し、目的の駅で降車する流れを以下のようにシミュレートします。

### 操作手順

購入する切符と乗車駅を選択し、「乗車する」ボタンをクリックします。

![screen shot 2017-07-11 at 8 33 11](https://user-images.githubusercontent.com/1148320/28044694-c5620494-6613-11e7-928f-cca198d66cb1.png)

降車駅を選択し、「降車する」ボタンをクリックします。

![screen shot 2017-07-11 at 8 33 19](https://user-images.githubusercontent.com/1148320/28044695-c58a7ad2-6613-11e7-88b8-13d2195b4a25.png)

降車可能な駅であれば、最初の画面に戻ります。

![screen shot 2017-07-11 at 8 33 22](https://user-images.githubusercontent.com/1148320/28044697-c595ee4e-6613-11e7-995b-3f547f0b9a1b.png)

降車できない場合はエラーメッセージが表示されます。

![screen shot 2017-07-16 at 8 20 45](https://user-images.githubusercontent.com/1148320/28243305-c075f784-69ff-11e7-84d1-7b7cdc5818fb.png)

### 運賃表

運賃は以下のようになっています。

仕様を複雑にしないよう、1区間 = 150円、2区間 = 190円で単純に固定されています。

|  |      |      |
|------|------|------|
| うめだ |      |      |
| 150  | じゅうそう |      |
| 190  | 150  | みくに |

### 駅番号

駅の並び順を明示的に表すために、このアプリケーションでは各駅に駅番号（`station_number`）を付与しています。

- うめだ = 1
- じゅうそう = 2
- みくに = 3

### 解答される方への注意事項

これはあくまで勉強会用のサンプルアプリケーションなので、ごくごく単純な仕様で実装しています。  
本番運用されることはないため、「こんな仕様も必要なのでは？」「こういうケースもありえるのでは？」といった深読みは不要です。

### 考慮不要な仕様の例

- 駅が増えたり減ったりするケース
- 運賃が変更されたり、「1区間 = 150円、2区間 = 190円」以外の運賃が登場したりするケース
- 出題内容以外の例外的な画面操作や、異常な入力値
- ユーザーの利便性を高めるためのUI改善

### 解答時の制限事項

解答時の実装方法は基本的に自由ですが、参加者の解答バリエーションが過度に増えてしまわないよう、以下の制限を設けます。

- ファイルを追加してはいけません（新しいクラスやマイグレーションを増やさない）。既存のファイルを変更するだけにしてください。
- 変更してよいファイルはモデルとコントローラのみとします。ビューやヘルパークラスは変更しないでください。
- テストコードは`skip`メソッドの行を削除する以外の変更を加えないでください（新しいテストパターンを増やさない）。
- Gemfileに新しいgemを追加しないでください。

### その他

今回のサンプルアプリケーションでは、Gateクラス（改札機クラス）に運賃が定数として埋め込まれています。  

```ruby
class Gate < ApplicationRecord
  FARES = [150, 190].freeze
end
```

「こんなところに運賃が定義されているのは設計としておかしい！」という意見もあるかもしれませんが、これはあくまで簡易的なサンプルアプリケーションということで、スルーしてやってください 🙇

## 解答の流れ

解答の流れは以下のとおりです。

- このリポジトリ（upstream）を自分のアカウントにフォークする
- 開発環境をセットアップする（下記参照）
- 設問を解く（内容は後述）
- 自分のリポジトリからupstreamに対して、Pull requestを作成する

### 【注意】模範解答と他の参加者のPull requestについて

以下のような操作をすると、出題者の模範解答や他の参加者が提出した解答が見えてしまいます。  

- 過去のcommit履歴をたどる
- answerブランチの中を覗く
- GitHubのPull requestsタブを開く

わざわざカンニングしてまでこの問題を解こうとする人はいないと思いますが、「意図せず他の人の解答が見えてしまった！」ということが起きないように注意してください。

## 解答に利用するRubyのバージョン

2.4.1を推奨。（ただし、2.2.2以上であれば可）

## 依存する外部アプリケーション

- Google Chrome （システムテストで使用）

## 必要となるPCの設定

ChromeDriverをインストールしてください。（システムテストで使用）

```
# Macの場合
brew update
brew install chromedriver
```

ChromeDriverを自分でダウンロードして、PATHの通ったディレクトリに配置するのもOKです。

- [Downloads \- ChromeDriver \- WebDriver for Chrome](https://sites.google.com/a/chromium.org/chromedriver/downloads)

## Railsのセットアップ

このリポジトリをフォークし、ローカルにcloneしたら、次のコマンドでセットアップを実行してください。

```
bin/setup
```

セットアップを実行したらRailsを起動し、 http://localhost:3000/ にアクセスしてください。  
正常に画面が表示されればOKです。

```
rails s
```

![screen shot 2017-07-11 at 8 33 11](https://user-images.githubusercontent.com/1148320/28044694-c5620494-6613-11e7-928f-cca198d66cb1.png)

## テストコードの実行

以下のコマンドを実行し、テストコードが正常に動作することを確認してください。

```
bin/rails test && bin/rails test:system
```

次のような表示になればOKです。

```
Running via Spring preloader in process 52004
Run options: --seed 35280

# Running:

SS.....S....

Finished in 0.078131s, 153.5882 runs/s, 127.9902 assertions/s.
12 runs, 10 assertions, 0 failures, 0 errors, 3 skips

You have skipped tests. Run with --verbose for details.
Run options: --seed 25329

# Running:

Puma starting in single mode...
* Version 3.9.1 (ruby 2.4.1-p111), codename: Private Caller
* Min threads: 0, max threads: 1
* Environment: test
* Listening on tcp://0.0.0.0:59843
Use Ctrl-C to stop
..S.SS

Finished in 3.057958s, 1.9621 runs/s, 1.3081 assertions/s.
6 runs, 4 assertions, 0 failures, 0 errors, 3 skips

You have skipped tests. Run with --verbose for details.
```

## 問題

ここから問題が始まります。  
以下の問題文をよく読んで、解答してください。

### Ex1. 運賃の計算（下り）

`test/models/gate_test.rb`を開き、「うめだで150円の切符を買って、みくにで降りる（運賃不足）」にある`skip 'Please implement this!'`の行を削除してください。

テストを実行し、テストが失敗することを確認してください。

```
$ bin/rails test
Running via Spring preloader in process 52209
Run options: --seed 34427

# Running:

.S.....SF

Failure:
GateTest#test_うめだで150円の切符を買って、みくにで降りる（運賃不足） [/Users/jit/dev/sandbox/train-ticket-rails/test/models/gate_test.rb:23]:
Expected true to not be truthy.


bin/rails test test/models/gate_test.rb:21

...

Finished in 0.075118s, 159.7487 runs/s, 146.4363 assertions/s.
12 runs, 11 assertions, 1 failures, 0 errors, 2 skips

You have skipped tests. Run with --verbose for details.
```

テストがパスするように実装してください。

### Ex2. 運賃の計算（上り）

`test/models/gate_test.rb`を開き、「みくにで150円の切符を買って、うめだで降りる（運賃不足）」にある`skip 'Please implement this!'`の行を削除してください。

Ex1と同じ要領で実装してください。

### Ex3. 同じ駅で降りる場合

`test/models/gate_test.rb`を開き、「同じ駅では降りられない」にある`skip 'Please implement this!'`の行を削除してください。

Ex1と同じ要領で実装してください。

### Ex4. 画面の実装

`test/system/tickets_test.rb`を開き、「運賃が足りない場合」と「同じ駅で降りる場合」のテストケースにある、`skip 'Please implement this!'`の行を削除してください。（計2箇所）

システムテストを実行し、テストが失敗することを確認してください。

```
$ bin/rails test:system
Run options: --seed 13045

# Running:

Puma starting in single mode...
* Version 3.9.1 (ruby 2.4.1-p111), codename: Private Caller
* Min threads: 0, max threads: 1
* Environment: test
* Listening on tcp://0.0.0.0:63717
Use Ctrl-C to stop
[Screenshot]: tmp/screenshots/failures_test_運賃が足りない場合.png

F

Failure:
TicketsTest#test_運賃が足りない場合 [/Users/jit/dev/sandbox/train-ticket-rails/test/system/tickets_test.rb:25]:
expected to find text "降車駅 では降車できません。" in "TrainTicketRails 降車しました。😄 切符 150円 190円 乗車駅 うめだ じゅうそう みくに 乗車する Image: Wikipedia"


bin/rails test test/system/tickets_test.rb:16

S...[Screenshot]: tmp/screenshots/failures_test_同じ駅で降りる場合.png

F

Failure:
TicketsTest#test_同じ駅で降りる場合 [/Users/jit/dev/sandbox/train-ticket-rails/test/system/tickets_test.rb:37]:
expected to find text "降車駅 では降車できません。" in "TrainTicketRails 降車しました。😄 切符 150円 190円 乗車駅 うめだ じゅうそう みくに 乗車する Image: Wikipedia"


bin/rails test test/system/tickets_test.rb:28



Finished in 9.524030s, 0.6300 runs/s, 0.8400 assertions/s.
6 runs, 8 assertions, 2 failures, 0 errors, 1 skips

You have skipped tests. Run with --verbose for details.
```

テストがパスするように実装してください。

### Ex5. 特殊ケースの実装

`test/system/tickets_test.rb`を開き、「すでに使用済みの切符を指定されたらトップページに移動する」のテストケースにある、`skip 'Please implement this!'`の行を削除してください。

Ex4と同じ要領で実装してください。

### Ex6. 最終確認＆Pull requestの作成

すべてのテストがパスすることを確認してください。

```
$ bin/rails test && bin/rails test:system
Running via Spring preloader in process 51715
Run options: --seed 52644

# Running:

............

Finished in 0.082952s, 144.6620 runs/s, 180.8275 assertions/s.
12 runs, 15 assertions, 0 failures, 0 errors, 0 skips
Run options: --seed 42830

# Running:

Puma starting in single mode...
* Version 3.9.1 (ruby 2.4.1-p111), codename: Private Caller
* Min threads: 0, max threads: 1
* Environment: test
* Listening on tcp://0.0.0.0:59614
Use Ctrl-C to stop
......

Finished in 4.896446s, 1.2254 runs/s, 2.4508 assertions/s.
6 runs, 12 assertions, 0 failures, 0 errors, 0 skips
```

実装が完了したら、Pull requestを作成して解答を提出してください。

### 備考

- 最後まで回答できなかった場合は、途中でギブアップして提出してもらってもOKです。
- こだわった点やアピールポイントがあれば、Pull requestのDescriptionに記述してください。

### ボーナス課題：制限事項を無視して実装してみる

この勉強会では解答のバリエーションが増えすぎないように制限事項をたくさん設けていますが、この問題を解いたみなさんはおそらく「自分だったらこう実装したい！」という思いがふつふつと沸いてくると思います。

解答を提出したら、今度は制限事項を無視して自分の好きなように実装してみてください。  
自分が書いたコードだけでなく、既存のコードをリファクタリングしていくのもOKです。

ただし、「制限事項を無視した実装」は今回の勉強会のレビュー対象外なので、勉強会の参加者同士や、会社の同僚と一緒にコードレビューしてください。

## お問い合わせ

何か不明な点があれば、[@jnchito](https://twitter.com/jnchito/)までご連絡ください。

## あわせて読みたい

この問題は「プロを目指す人のためのRuby入門」（2017年11月発売予定）で使用した例題がベースになっています。

[【鋭意制作中】Rubyの入門本「プロを目指す人のためのRuby入門」を執筆しています \- give IT a try](http://blog.jnito.com/entry/2017/05/30/120148)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

