# Translations

Translation management application.

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

TODO: escape quotes and `"."`

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
