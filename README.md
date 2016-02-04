# MP::Translations

gettext style translations for the MyPlay platform.

## Overview

`MP::Translations` provides a UI for managing translations and backends that allow applications to use them.
It was designed around [Ruby's I18n](https://github.com/svenfuchs/i18n), but  translations can be retrieved by any client.

## Backends

Translation modifications are pushed to Redis *and* saved to the database (I18n is used to push the translations to Redis).

Translations can also be exported to gettext PO files.

### Redis

Translations are saved in Redis using the following keys:

	language."text"

Where `language` is an [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code and `"text"` is the *source* translation.
For example, if the English source text "The rats sleep in the subway" was translated into Portuguese and Spanish the following keys
would be created:

	es."The rats sleep in the subway"
	pt."The rats sleep in the subway"

TODO: escaping quotes and `"."`

### PO Files

There's a `thor` task for this

### Database

TODO; for now See `config/schema.rb`

## Installation

You need a MySQL database.

### Development

1. `git clone git@github.com:rgenerator/mp-translations.git`
1. `cd mp-translations`
1. `cp config/database.yml.default config/database.yml`
1. Add DB connection info to `config/database.yml`
1. [Install Redis](http://redis.io/download) (optional -but recommended)
1. `bundle install`
1. `bundle exec rails s`

### Everywhere Else

Capistrano is used for deployments.

1. [Install Redis](http://redis.io/download) somewhere that can be accessed by `MP::Translations`
1. Edit `config/initializers/translation_cache.rb` (should not be required unless there's a server change)
1. Edit `config/deploy/production.rb` (or `staging.rb`, ... should not be required unless there's a server change)
1. Deploy from [the build server](https://us-3.rightscale.com/acct/11898/servers/1065247003) as the build user (or elsewhere): `cap production deploy # or staging`
