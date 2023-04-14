all: composer update links completion

composer:
	test -d bin || mkdir bin
	test -f bin/composer || curl -sS https://getcomposer.org/installer | php -- --quiet --install-dir=bin --filename=composer

update:
	./bin/composer self-update
	./bin/composer --working-dir=php_codesniffer update
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

completion:
	test -d bash_completion.d || mkdir bash_completion.d
	./bin/composer completion bash > bash_completion.d/composer.sh
	./bin/phpstan completion bash > bash_completion.d/phpstan.sh
	./bin/phpstan-strict completion bash > bash_completion.d/phpstan-strict.sh

outdated:
	./bin/composer --working-dir=php_codesniffer outdated --direct
	./bin/composer --working-dir=phpstan outdated --direct
	./bin/composer --working-dir=phpstan-strict outdated --direct
	./bin/composer --working-dir=phpunit outdated --direct
	./bin/composer --working-dir=psalm outdated --direct
	./bin/composer --working-dir=tools outdated --direct

clean:
	rm -Rf bash_completion.d bin */bin */composer.lock */vendor
