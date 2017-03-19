#!/bin/bash

sed -i 's/QINIU_ACCESS_KEY/'"$QINIU_ACCESS_KEY"'/g' /opt/data/qiniu/qupload_*.json
sed -i 's/QINIU_SECRET_KEY/'"$QINIU_SECRET_KEY"'/g' /opt/data/qiniu/qupload_*.json
/opt/tools/qshell/qshell_linux_amd64 qupload 20 /opt/data/qiniu/qupload_assets.json
/opt/tools/qshell/qshell_linux_amd64 qupload 20 /opt/data/qiniu/qupload_files.json

JEKYLL_ENV=production jekyll serve

