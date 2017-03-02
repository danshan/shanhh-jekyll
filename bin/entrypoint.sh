#!/bin/bash

service nginx start

# /jekyll/tools/qshell/qshell_linux_amd64 account $QINIU_ACCESS_KEY $QINIU_SECRET_KEY

sed -i 's/QINIU_ACCESS_KEY/'"$QINIU_ACCESS_KEY"'/g' /jekyll/qiniu/qupload_*.json
sed -i 's/QINIU_SECRET_KEY/'"$QINIU_SECRET_KEY"'/g' /jekyll/qiniu/qupload_*.json
/jekyll/tools/qshell/qshell_linux_amd64 qupload /jekyll/qiniu/qupload_assets.json
/jekyll/tools/qshell/qshell_linux_amd64 qupload /jekyll/qiniu/qupload_files.json

while :; do
  sleep 3000
done