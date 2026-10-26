# Журнал команд · практическая работа №3

ФИО: Товстенко Оскар
Группа: 9/2-РПО-25/1
Дата: 25.10.2026

В журнал записывается каждая команда, которая изменила файлы или помогла найти ответ.
Безопасный пример — вариант команды, который сначала показывает результат и ничего не удаляет.

| № | Команда | Что сделала | Безопасный пример |
|---|---|---|---|
| 1 | `mkdir -p ~/files-lab/sorted/{docs,images,logs,data}` | Создала `sorted` и четыре подкаталога одной командой | `mkdir -pv ~/files-lab/sorted/{docs,images,logs,data}` |
| 2 | `mv "my report.txt" my-report.txt` | Убрала пробел из имени отчёта | `ls -l "my report.txt"` |
| 3 | `mv report-*.txt my-report.txt ~/files-lab/sorted/docs/` | Перенесла все отчёты в `sorted/docs` | `ls report-*.txt my-report.txt` |
| 4 | `mv *.{jpg,png} ~/files-lab/sorted/images/` | Перенесла jpg и png в `sorted/images` | `ls *.{jpg,png}` |
| 5 | `mv app.log app.log.1 app.log.2 error.log ~/files-lab/sorted/logs/` | Перенесла четыре журнала в `sorted/logs` | `ls app.log app.log.1 app.log.2 error.log` |
| 6 | `cp *.csv ~/files-lab/sorted/data/` | Скопировала таблицы, оригиналы остались в `inbox` | `ls *.csv` |
| 7 | `ls *.bak` | Показала, какие файлы попадут под удаление | `ls *.bak` |
| 8 | `rm -v *.bak` | Удалила резервные копии в `inbox` | `rm -i *.bak` |
| 9 | `find ~/files-lab -type f -size +1M -exec ls -lh {} \;` | Нашла `dump.bin` размером 5.0M | та же команда без `-delete` |
| 10 | `find ~/files-lab -type f -size +1M -delete` | Удалила файл больше 1 МБ | `find ~/files-lab -type f -size +1M` |
| 11 | `find inbox -type f -mtime +30 > ~/files-lab/answers.txt` | Записала в ответы файлы старше 30 суток | `find inbox -type f -mtime +30` |
| 12 | `cat .settings >> ~/files-lab/answers.txt` | Дописала содержимое скрытого файла | `ls -A inbox` |
| 13 | `printf '%s\n' 'ls -l -S ~/files-lab/sorted/images' >> ~/files-lab/answers.txt` | Дописала команду сортировки по размеру. В `man ls` ключ `-S` — sort by file size | `man ls`, поиск `/sort by file size` |
| 14 | `locate os-release \| head -1 >> ~/files-lab/answers.txt` | Дописала первый путь к `os-release` | `locate os-release` |
