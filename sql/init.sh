#!/bin/sh

set -ex
cd `dirname $0`

ISUCON_DB_HOST=${ISUCON_DB_HOST:-127.0.0.1}
ISUCON_DB_PORT=${ISUCON_DB_PORT:-3306}
ISUCON_DB_USER=${ISUCON_DB_USER:-isucon}
ISUCON_DB_PASSWORD=${ISUCON_DB_PASSWORD:-isucon}
ISUCON_DB_NAME=${ISUCON_DB_NAME:-isuports}

# MySQLを初期化
mysql -u"$ISUCON_DB_USER" \
		-p"$ISUCON_DB_PASSWORD" \
		--host "$ISUCON_DB_HOST" \
		--port "$ISUCON_DB_PORT" \
		"$ISUCON_DB_NAME" < init.sql

# SQLiteのデータベースを初期化
rm -f ../tenant_db/*.db
cp -r ../../initial_data/*.db ../tenant_db/
# SQLiteに対してINDEXを作成
# データベースファイルの一覧を取得
DB_FILES=$(find ../tenant_db -name *.db)
# 各データベースファイルに対してSQLを実行
SQL_FILE=tenant/11_index.sql
for DB_FILE in $DB_FILES; do
    echo "Executing SQL file $SQL_FILE on database $DB_FILE"
    sqlite3 "$DB_FILE" < "$SQL_FILE"
    echo "Done"
done