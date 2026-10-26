# Файлы, маски, поиск и справка · отчёт

ФИО: Товстенко Оскар
Группа: 9/2-РПО-25/1
Дата: 25.10.2026
Среда: Ubuntu 26.04.1 LTS (Resolute Raccoon), VirtualBox, пользователь `vboxuser`

## Каталог site

Команды:

```bash
mkdir site
mkdir site/img/icons
mkdir -p site/css site/img/icons
touch site/index.html site/css/style.css site/img/icons/logo.png
tree site
```

![Каталог site](screenshots/01-site-tree.png)

Результат: `mkdir site/img/icons` ответил `No such file or directory`. С `-p` каталоги создались. `tree site` показал 4 каталога и 3 файла: `index.html`, `css/style.css`, `img/icons/logo.png`.

Почему mkdir без -p сообщил об ошибке.

Вывод: без `-p` команда `mkdir` создаёт только последний каталог и требует, чтобы родитель уже существовал. Каталога `site/img` не было, поэтому `site/img/icons` не создался. `-p` создаёт весь путь и не выдаёт ошибку, если каталог уже есть.

## Учебный набор

Команды:

```bash
ls inbox
ls -A inbox
```

![Учебный набор](screenshots/02-inbox.png)

Результат: обычный `ls` показал `README.TXT`, `archive`, `data-old.csv`, `data.csv`, `notes.md`, `todo.md`. `ls -A` добавил `.settings`.

Какой файл виден только с ключом -A и почему.

Вывод: только `.settings`. Имена, которые начинаются с точки, скрытые. `ls` их не показывает, `ls -A` показывает. В файле записано `token=lab-only`.

## Копирование с вопросом

Команды:

```bash
mkdir -p ~/files-lab/backup
cp data.csv ../backup/
cp -i data.csv ../backup/
```

![Копирование с вопросом](screenshots/03-cp-i.png)

Результат: первая копия прошла молча. Повтор с `-i` остановился на вопросе `cp: overwrite '../backup/data.csv'?`. Ответ был `n`, файл не заменялся.

Что сделает cp без -i, если файл уже есть.

Вывод: без `-i` команда `cp` заменяет существующий файл без вопроса. `-i` спрашивает, `-n` пропускает уже существующий файл.

## Удаление каталога

Команды:

```bash
rm old
rmdir old
rm -rv old
```

![Удаление каталога](screenshots/04-rmdir.png)

Результат: `rm old` — `Is a directory`. `rmdir old` — `Directory not empty`. `rm -rv old` удалил `old/keep/a.txt`, затем каталоги `old/keep` и `old`.

Чем rmdir отличается от rm -r.

Вывод: `rmdir` удаляет только пустой каталог. `rm` без `-r` каталог не удаляет. `rm -r` удаляет каталог вместе с содержимым, `-v` печатает, что именно удалено. Перед `rm` тот же путь стоит посмотреть через `ls`.

## Маски

Команды:

```bash
ls *.txt
ls photo-00[1-3].jpg
echo *.docx
```

![Маски](screenshots/05-masks.png)

Результат: `*.txt` вывел `my report.txt` и отчёты `report-2026-01`, `02`, `03`, `10`, `11`, `report-final.txt`. `README.TXT` не попал: регистр другой. `photo-00[1-3].jpg` вывел только `photo-001.jpg`, `photo-002.jpg`, `photo-003.jpg`. `echo *.docx` напечатал `*.docx`.

Кто раскрывает маску и что получает команда, если совпадений нет.

Вывод: маску раскрывает оболочка до запуска команды. Команда получает уже готовый список имён. Если совпадений нет, bash передаёт текст маски как есть, поэтому `echo` показал `*.docx`. Скобки `[1-3]` — один символ из диапазона. Перед `rm` ту же маску проверяют через `ls`.

## Поиск find

Команды:

```bash
find inbox -type f -size +1M -exec ls -lh {} \;
find inbox -type f -size -1M
find inbox -mtime +30
```

![Поиск find](screenshots/06-find.png)

Результат: больше 1 МБ нашёлся один файл, `inbox/dump.bin`, 5.0M. `find -size -1M` не вывел ничего. Старше 30 суток были `archive/2025/plan.txt`, `archive/2025/budget.csv`, `config.yaml.bak`, `app.log.2`, `app.log.1`, `report-2026-02.txt`, `report-2026-03.txt`, `data-old.csv`, `report-2026-01.txt`.

Почему -size -1M не нашёл ни одного файла.

Вывод: `find` округляет размер вверх до указанной единицы. Для единицы `M` даже небольшой непустой файл считается как 1M. Условие `-1M` означает «меньше 1M после округления», поэтому непустые файлы в него не попадают. `+1M` как раз поймал `dump.bin`.

## Поиск locate

Команды:

```bash
touch to-delete.txt
sudo updatedb
locate to-delete.txt
rm to-delete.txt
locate to-delete.txt
locate -e to-delete.txt
```

![Поиск locate](screenshots/07-locate.png)

Результат: после `updatedb` путь был `/home/vboxuser/files-lab/to-delete.txt`. После `rm` обычный `locate` показал тот же путь. `locate -e` не вывел ничего, код завершения `0`.

Почему locate выводит путь удалённого файла.

Вывод: `locate` читает базу, собранную `updatedb`, а не текущий диск. База обновляется не в момент удаления. `locate -e` проверяет, что файл ещё существует, и старый путь не печатает.

## Справка

Команды:

```bash
man -P cat ls | grep -n -i -A 6 'sort by file size'
```

![Справка](screenshots/08-man.png)

Результат: на строке 143 страницы `man ls` написано `-S  Sort by file size, largest first.`

Какой ключ сортирует по размеру и как вы его нашли.

Вывод: ключ `-S`. Его строка нашлась поиском текста `sort by file size` в странице `man ls`. Рядом для сравнения: `-t` сортирует по времени изменения.

## Результат квеста

Команды:

```bash
tree ~/files-lab/sorted
```

![Результат квеста](screenshots/09-sorted.png)

Результат: `5 directories, 19 files`.

Сколько файлов в каждом подкаталоге.

Вывод: `data` — 2 таблицы (`data.csv`, `data-old.csv`), `docs` — 7 отчётов, включая `my-report.txt`, `images` — 6 файлов (пять jpg и `photo-010.png`), `logs` — 4 журнала (`app.log`, `app.log.1`, `app.log.2`, `error.log`).

## Проверка

Команды:

```bash
bash ~/Downloads/files-lab-check.sh
```

![Проверка](screenshots/10-check.png)

Результат: `Итог: 12 из 12`.

Итог проверки; какие пункты потребовали исправления.

Вывод: первый прогон дал 11 из 12. Пункт 10 искал в `answers.txt` подряд символы `-S`. Строка `ls -lS` их не содержит: после дефиса стоит `l`. В ответ записана команда `ls -l -S ~/files-lab/sorted/images`. После этого все 12 пунктов — `OK`.

## Ответы

Содержимое answers.txt:

```text
inbox/archive/2025/plan.txt
inbox/archive/2025/budget.csv
inbox/data-old.csv
token=lab-only
ls -l -S ~/files-lab/sorted/images
/etc/os-release
```

Три пути — файлы `inbox`, которым больше 30 суток и которые остались в `inbox` после переноса. `token=lab-only` — содержимое `.settings`. Дальше команда сортировки по размеру и первый путь `locate os-release`.

## Перед сдачей

- [+] Проверка: 12 из 12.
- [+] Снимки открываются.
- [+] journal.md заполнен.
