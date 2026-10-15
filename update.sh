#!/bin/bash
# Re-mirror terbaru dari apple.com
set -e
cd /tmp
rm -rf apple-site && mkdir -p apple-site && cd apple-site
wget --mirror --page-requisites --convert-links --adjust-extension --no-parent \
  -e robots=off --domains=www.apple.com,apple.com --span-hosts \
  https://www.apple.com/iphone-duo/
SRC=/tmp/apple-site/www.apple.com
DST=/home/runner/iphone-duo-clone
for d in v ac api-www metrics; do
  [ -d "$SRC/$d" ] && cp -r "$SRC/$d" "$DST/"
done
curl -sL -A "Mozilla/5.0" "https://www.apple.com/iphone-duo/" -o "$DST/index.html"
echo "updated $(du -sh $DST)"
