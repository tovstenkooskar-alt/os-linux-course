# Модель доступа проекта study-bot

Проект: бот для конспектов курса. Код бота и заметки лежат отдельно, чтобы автор заметок не менял программу, а разработчик не правил чужие конспекты.

Скрипт `setup-team.sh` запущен в виртуальной машине. После снятия вывода учебные учётные записи удалены.

## Роли

| Роль | Учётная запись | Группы | Может | Не может |
|---|---|---|---|---|
| руководитель | anna | bot-dev, bot-qa, sudo | код, заметки и администрирование | — |
| разработчик | boris | bot-dev | писать код в `app` | открывать `notes`, вызывать sudo |
| редактор конспектов | vera | bot-qa | писать заметки в `notes` | открывать `app`, вызывать sudo |
| наблюдатель | oleg | только личная группа oleg | свой домашний каталог | `app`, `notes`, sudo |

## Каталоги

| Каталог | Группа | Права | Кто работает |
|---|---|---|---|
| `/srv/study-bot/app` | bot-dev | `2770` · `drwxrws---` | anna, boris |
| `/srv/study-bot/notes` | bot-qa | `2770` · `drwxrws---` | anna, vera |

## Вывод id

```text
uid=1005(anna) gid=1009(anna) groups=1009(anna),27(sudo),1007(bot-dev),1008(bot-qa)
uid=1006(boris) gid=1010(boris) groups=1010(boris),1007(bot-dev)
uid=1007(vera) gid=1011(vera) groups=1011(vera),1008(bot-qa)
uid=1008(oleg) gid=1012(oleg) groups=1012(oleg)
```

## Вывод ls -l /srv/study-bot

```text
drwxrws--- 2 root bot-dev 4096 Oct 25 14:45 app
drwxrws--- 2 root bot-qa  4096 Oct 25 14:45 notes
```

![Запуск setup-team.sh](screenshots/10-setup.png)

## Тесты доступа

| № | Пользователь | Команда | Ожидается | Получено |
|---|---|---|---|---|
| 1 | boris | `touch /srv/study-bot/app/bot.py` | разрешено | разрешено, код 0 |
| 2 | boris | `ls /srv/study-bot/notes` | Permission denied | `Permission denied`, код 2 |
| 3 | vera | `touch /srv/study-bot/notes/lecture.md` | разрешено | разрешено, код 0 |
| 4 | vera | `ls /srv/study-bot/app` | Permission denied | `Permission denied`, код 2 |
| 5 | oleg | `ls /srv/study-bot/app` | Permission denied | `Permission denied`, код 2 |
