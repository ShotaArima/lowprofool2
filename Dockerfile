# ベースイメージの指定
FROM python:3.8

## wgetとunzipをインストール
#RUN apt-get update && apt-get install -y wget unzip
# 証明書とシステムパッケージの更新
RUN apt-get update && \
    apt-get install -y gnupg2 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A && \
    apt-get update && \
    apt-get install -y --force-yes \
    ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /src/

# requirements.txtをコピーして環境を作成
COPY src/requirements.txt /src/
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt
## デフォルトでAnaconda環境をアクティブ化
#SHELL ["/bin/bash", "-c"]

# ポートの公開
EXPOSE 9004

# 日本語フォントの設定
# RUN wget -O font.zip "https://moji.or.jp/wp-content/ipafont/IPAexfont/ipaexg00401.zip"
# RUN unzip font.zip
# RUN cp ipaexg00401/ipaexg.ttf {/opt/conda/envs/~/ttf}/ipaexg.ttf
# RUN echo "font.family : IPAexGothic" >>  {/opt/conda/~/matplotlibrc}
