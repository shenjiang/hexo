FROM ubuntu:14.04
MAINTAINER Shen Jiang 

RUN \
  # use aliyun's mirror for faster download speed
  #sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y nodejs npm curl git-core && \
  # use nodejs as node 
  update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
  # install npm
  #curl -L https://npmjs.org/install.sh | sh && \
  #npm install npm@latest -g && \
  # clean up install cache
  #apt-get clean && \
  #rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN \
  mkdir blog && cd blog && \
  # install hexo
  npm install hexo-cli -g && \
  hexo init && npm install && \
  # install plugins for hexo
  npm install hexo-generator-sitemap --save && \
  npm install hexo-generator-feed --save && \
  npm install hexo-deployer-git --save && \
  npm un hexo-renderer-marked --save && \
  npm i hexo-renderer-markdown-it --save

WORKDIR /root/blog/

VOLUME ["/root/blog/"]
#VOLUME ["/root/blog/themes"]

EXPOSE 4000

CMD exec hexo s

