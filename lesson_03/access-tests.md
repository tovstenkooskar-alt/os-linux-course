# Таблица тестов доступа · команда mobile-app

ФИО: Товстенко Оскар
Группа: 9/2-РПО-25/1
Дата: 25.10.2026

Графа «Ожидается» записана по схеме ролей до сравнения с выводом. Команды выполнены в Ubuntu 26.04.1, пользователь `vboxuser`.

| № | Пользователь | Команда | Ожидается | Получено |
|---|---|---|---|---|
| 1 | lead | `sudo -u lead touch /srv/mobile/src/lead.txt` | разрешено | разрешено, `lead-src:ok` |
| 2 | lead | `sudo -u lead ls /srv/mobile/reports` | разрешено | разрешено, `lead-reports:ok` |
| 3 | dev | `sudo -u dev touch /srv/mobile/src/main.kt` | разрешено | разрешено, `dev-src:ok` |
| 4 | dev | `sudo -u dev ls /srv/mobile/reports` | отказ: `Permission denied` | `Permission denied`, код 2 |
| 5 | qa | `sudo -u qa touch /srv/mobile/reports/test-1.md` | разрешено | разрешено, `qa-reports:ok` |
| 6 | qa | `sudo -u qa ls /srv/mobile/src` | отказ: `Permission denied` | `Permission denied`, код 2 |
| 7 | guest | `sudo -u guest ls /srv/mobile/src` | отказ: `Permission denied` | `Permission denied`, код 2 |
| 8 | guest | `sudo -u guest ls /srv/mobile/reports` | отказ: `Permission denied` | `Permission denied`, код 2 |

## Схема ролей

| Роль | Учётная запись | Группы | Каталоги | Может | Не может |
|---|---|---|---|---|---|
| руководитель | lead | mobile-dev, mobile-qa, sudo | src, reports | читать и менять оба каталога, вызывать sudo | — |
| разработчик | dev | mobile-dev | src | создавать файлы в `src` | открывать `reports`, вызывать sudo |
| тестировщик | qa | mobile-qa | reports | создавать файлы в `reports` | открывать `src`, вызывать sudo |
| внешний сотрудник | guest | только личная группа guest | — | работать в своём домашнем каталоге | `src`, `reports`, sudo |

## Почему постоянная работа под root опасна

Три примера из занятия:

1. Команда вроде `rm -r` под root не упирается в права каталога. Ошибка в пути удаляет системные файлы, а не только учебный каталог.
2. Чужой человек в сессии root читает `/etc/shadow` и меняет любую учётную запись. Обычный пользователь этот файл даже открыть не может: у него права `rw-r-----`, группа `shadow`.
3. Если все работают как root, в журнале sudo не видно, кто именно выполнил команду. `sudo` записывает имя настоящего пользователя, поэтому отказ `guest` остаётся отдельной строкой, а не общим следом root.
