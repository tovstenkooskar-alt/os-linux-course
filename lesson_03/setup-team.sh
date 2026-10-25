#!/bin/bash
# Модель доступа проекта study-bot. Запуск: sudo bash setup-team.sh
set -euo pipefail

groupadd -f bot-dev
groupadd -f bot-qa

for user in anna boris vera oleg; do
  id "$user" >/dev/null 2>&1 || useradd -m -s /bin/bash "$user"
done

printf '%s\n' 'anna:StudyBot1' 'boris:StudyBot1' 'vera:StudyBot1' 'oleg:StudyBot1' | chpasswd

usermod -aG bot-dev,bot-qa,sudo anna
usermod -aG bot-dev boris
usermod -aG bot-qa vera

mkdir -p /srv/study-bot/app /srv/study-bot/notes
chgrp bot-dev /srv/study-bot/app
chgrp bot-qa /srv/study-bot/notes
chmod 2770 /srv/study-bot/app /srv/study-bot/notes

echo "=== id ==="
id anna boris vera oleg
echo "=== ls -l /srv/study-bot ==="
ls -l /srv/study-bot
