# -- デプロイ --
# ベンチを回す
bench:
	cd ~/bench && ./bench -target-addr localhost:443

# ログをローテートする、ベンチ前にやる
clean-log:
	sudo truncate -s 0 /var/log/nginx/access.log /var/log/nginx/error.log /var/log/mysql/mysql.log /var/log/mysql/mysql-slow.log

# DBを再構築する
reconstruct:
	cd sql && ./reconstruct.sh

# デプロイ
deploy:
	sudo service isuports restart

# -- 解析 --
# スロークエリの解析
analyze-slow:
	sudo cat /var/log/mysql/mysql-slow.log | docker run -i --rm matsuu/pt-query-digest > analyzed-slow.log

# アクセスログの解析
analyze-access:
	cat /var/log/nginx/access.log | alp json --config config/alp.yml 

# -- 開発 --
# MySQLに接続
mysql:
	mysql -uroot -p isuports
