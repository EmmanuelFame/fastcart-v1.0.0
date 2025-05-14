APP_NAME=fastcart
PHP_CONTAINER=$(APP_NAME)-php

up:
	docker-compose up -d --build

down:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d --build

bash:
	docker exec -it $(PHP_CONTAINER) bash

artisan:
	docker exec -it $(PHP_CONTAINER) php artisan $(args)

composer:
	docker exec -it $(PHP_CONTAINER) composer $(args)

npm:
	docker exec -it $(PHP_CONTAINER) npm $(args)

migrate:
	docker exec -it $(PHP_CONTAINER) php artisan migrate

seed:
	docker exec -it $(PHP_CONTAINER) php artisan db:seed

queue:
	docker exec -it $(PHP_CONTAINER) php artisan queue:work

tinker:
	docker exec -it $(PHP_CONTAINER) php artisan tinker
