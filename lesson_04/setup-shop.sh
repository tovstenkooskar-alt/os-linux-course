#!/bin/bash
# Каталог проекта shop. Запуск: sudo bash setup-shop.sh
set -euo pipefail

groupadd -f shop-dev

for user in alex bella chris; do
  id "$user" >/dev/null 2>&1 || useradd -m -s /bin/bash "$user"
done

usermod -aG shop-dev alex
usermod -aG shop-dev bella

mkdir -p /srv/shop/src /srv/shop/releases /srv/shop/uploads
chgrp shop-dev /srv/shop/src /srv/shop/releases /srv/shop/uploads
chmod 2770 /srv/shop/src
chmod 2775 /srv/shop/releases
chmod 3770 /srv/shop/uploads

echo "=== id ==="
id alex bella chris
echo "=== ls -l /srv/shop ==="
ls -l /srv/shop
