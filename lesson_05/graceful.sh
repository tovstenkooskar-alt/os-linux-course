#!/bin/bash
# Аккуратное завершение по TERM. Запуск: ./graceful.sh
TMP="/tmp/graceful-$$.tmp"
echo "temp file: $TMP"
echo "temp file: $TMP" > "$TMP"

trap 'rm -f "$TMP"; echo "TERM получен, удаляю $TMP"; exit 0' TERM

while true; do
  sleep 1
done
