FROM ubuntu

RUN apt-get update && apt-get install -y mecab libmecab-dev mecab-ipadic-utf8 build-essential wget curl jq nkf

## create workspace
VOLUME /MECAB
WORKDIR /MECAB
ENV MECAB_WORK /MECAB
ENV MECAB_DIC /MECAB/mecab-ipadic-2.7.0-20070801

## Configire mecab dictionaly
RUN wget 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7bnc5aFZSTE9qNnM' -O model.bz2
RUN bzip2 -d model.bz2
RUN nkf -w --overwrite ./model
RUN sed -i 's/euc-jp/utf-8/' ./model
RUN wget 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM' -O mecab-ipadic.tar.gz
RUN tar zxf mecab-ipadic.tar.gz
RUN nkf -w --overwrite ${MECAB_DIC}/*.def
RUN nkf -w --overwrite ${MECAB_DIC}/*.csv
WORKDIR ${MECAB_DIC}
RUN ./configure
RUN make

## copy add_word csvs
COPY ./words /words

## create add_word csvs
VOLUME /app
WORKDIR /app

## cost
WORKDIR /app
RUN /usr/lib/mecab/mecab-dict-index -m ${MECAB_WORK}/model -d ${MECAB_DIC} -u add_cost.csv -f utf-8 -t utf-8 -a /words/*.csv

## create dictionary
RUN /usr/lib/mecab/mecab-dict-index -m ${MECAB_WORK}/model -d ${MECAB_DIC} -u original.dic add_cost.csv

