mecab-original-dic-builder
---

mecab ipadicに単語を追加し、ユーザー辞書をつくるためのシンプルなツールです。

## dependency

Docker

## usage

words/ にcsvファイルを追加してください。
(ファイル名は任意、文字コードはUTF-8、単語のコストは空にしてください)

```bash
$ echo ユーザー辞書2,,,,名詞,一般,*,*,*,*,ユーザー辞書2,ユーザージショ2,ユーザージショ2,オリジナル単語 > original.csv
```

makeを実行することで、Dockerコンテナ内で単語の自動コスト推定とユーザー辞書の作成を行います。

```bash
$ make
```

dist/ にcsvファイルが出力されます。
 - dist/add_cost.csv
   - 単語に自動コスト推定でコストを追加したファイル
 - dist/original.dic
   - ユーザー辞書ファイル

## 目的
Mecabで利用できる有力な辞書は2023/11/13現在の下記の３つがあります。
ipadic, neologd, UniDic

Mecabでの多くの利用目的では、neologd, UniDicを利用する、またはそれらに単語を追加することが望ましいです。
しかし、neologd, UniDicは辞書サイスが大きいです。

ipadicに単語を追加することで、必要最小限サイズのユーザー辞書を作成できると考えます。

