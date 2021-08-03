all: composer update links

composer:
	test -d bin || mkdir bin
	test -f bin/composer || curl -sS https://getcomposer.org/installer | php -- --quiet --install-dir=bin --filename=composer

update:
	./bin/composer self-update
	./bin/composer --working-dir=phpstan update
	./bin/composer --working-dir=phpstan-strict update
	./bin/composer --working-dir=phpunit update
	./bin/composer --working-dir=psalm update
	./bin/composer --working-dir=tools update

links:
	ln -sf ../phpstan-strict/bin/phpstan bin/phpstan-strict
	ln -sf ../phpstan/bin/phpstan bin/phpstan
	ln -sf ../phpunit/bin/phpunit bin/phpunit
	ln -sf ../psalm/bin/psalm bin/psalm

clean:
	rm -Rf bin */bin */composer.lock */vendor
