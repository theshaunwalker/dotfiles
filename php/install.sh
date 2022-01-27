install_composer() {
    EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
    then
        >&2 echo 'ERROR: Invalid installer checksum'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    rm composer-setup.php
    mv composer.phar ~/bin/composer
}


# Check for Homebrew
if test ! $(which composer)
    composer self-update
then
    install_composer
fi

# symlink the my-php-cli.ini file that *.symlink should have already linked to $HOME
# into all of the homebrew php's conf.d directories
# Same extra ini file for every version. Assuming
link_cli_ini () {
  find /opt/homebrew/etc/php -type d -name '*conf.d*' | while read found_dir
  do
    link_file ~/.my-php-cli.ini $found_dir/1-my-php-cli.ini
  done
}
# Symlink custom CLI php ini stuff to homebrew package locations
link_cli_ini

if ! pecl list | grep xdebug >/dev/null 2>&1;
then
    pecl install xdebug
fi

return 0