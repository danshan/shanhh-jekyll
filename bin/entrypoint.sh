#!/bin/bash

service nginx start

# /jekyll/tools/qshell/qshell_linux_amd64 account $QINIU_ACCESS_KEY $QINIU_SECRET_KEY

sed -i 's/QINIU_ACCESS_KEY/'"$QINIU_ACCESS_KEY"'/g' /opt/data/qiniu/qupload_*.json
sed -i 's/QINIU_SECRET_KEY/'"$QINIU_SECRET_KEY"'/g' /opt/data/qiniu/qupload_*.json
/opt/data/tools/qshell/qshell_linux_amd64 qupload /opt/data/qiniu/qupload_assets.json
/opt/data/tools/qshell/qshell_linux_amd64 qupload /opt/data/qiniu/qupload_files.json

while :; do
  sleep 3000
done