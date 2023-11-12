mecab-original-dic-builder
---

mecab ipadicに単語を追加し、ユーザー辞書をつくるためのシンプルなツールです。

## dependency

Docker

## usage

words/ にcsvファイルを追加してください。  
(ファイル名は任意、文字コードはUTF-8、単語のコストは空にしてください)

```bash
$ cp example/add_word.csv words/original.csv
$ echo ユーザー辞書2,,,,名詞,一般,*,*,*,*,ユーザー辞書2,ユーザージショ2,ユーザージショ2,オリジナル単語 >> words/original.csv
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
Mecabで利用できる辞書は、2023/11/13現在の以下の３つが有力です。  
ipadic, neologd, UniDic  

Mecabの利用する場合、neologd, UniDicを利用する、またはそれらに単語を追加することで目的を達成することが多いかと思われます。  
しかし、neologd, UniDicは辞書サイスが大きくなっています。

そのため、必要最小限サイズのユーザー辞書を作成する場合は、ipadicに単語を追加することで実現できると考えています。

