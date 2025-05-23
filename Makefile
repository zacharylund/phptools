all: composer update links completion

composer:
	test -d bin || mkdir bin
	test -f bin/composer || curl -sS https://getcomposer.org/installer | php -- --quiet --install-dir=bin --filename=composer

update:
	./bin/composer self-update
	./bin/composer --working-dir=php_codesniffer update
	./bin/composer --working-dir=phpmd update
	./bin/composer --working-dir=phpstan update
	./bin/composer --working-dir=psalm update
	./bin/composer --working-dir=rector update
	./bin/composer --working-dir=tools update

links:
	ln -sf ../phpmd/bin/phpmd bin/phpmd
	ln -sf ../phpstan/bin/phpstan bin/phpstan
	ln -sf ../psalm/bin/psalm bin/psalm
	ln -sf ../rector/bin/rector bin/rector

completion:
	test -d bash_completion.d || mkdir bash_completion.d
	./bin/composer completion bash > bash_completion.d/composer.sh
	./bin/phpstan completion bash > bash_completion.d/phpstan.sh

outdated:
	./bin/composer --working-dir=php_codesniffer outdated --direct
	./bin/composer --working-dir=phpmd outdated --direct
	./bin/composer --working-dir=phpstan outdated --direct
	./bin/composer --working-dir=psalm outdated --direct
	./bin/composer --working-dir=rector outdated --direct
	./bin/composer --working-dir=tools outdated --direct

clean:
	rm -Rf bash_completion.d bin */bin */composer.lock */vendor
