# Spree Pagseguro (Brazilian Gateway)

Add support for Pagseguro checkout as a payment method.
__Only tested on Spree 2.1.3__

## Installation

1. Add the following to your Gemfile

    gem 'spree_pagseguro', github: 'jnettome/spree_pagseguro'

2. Run `bundle install`

3. To copy and apply migrations run: `rails g spree_pagseguro:install`

## Configuring

1. Add a new Payment Method, using: `BillingIntegration::Pagseguro::Checkout` as the `Provider`

2. Click `Create`, and enter your Store's Pagseguro Email and Token in the fields provided.

3. `Save` and enjoy!

## Running live

For spree_pagseguro works as expected, we need to use master branch of `heavenstudio/pag_seguro`. Because the last versions wasn't released yet, force on your main spree application Gemfile the following:

    gem 'pag_seguro', github: 'heavenstudio/pag_seguro', branch: 'master'


Testing
-------

To make real tests (pagseguro doesn't provide sandbox), before running tests set environment variables `SPREE_PAGSEGURO_EMAIL` and `SPREE_PAGSEGURO_TOKEN` with valid credentials. To generate a token [see this](https://pagseguro.uol.com.br/integracao/token-de-seguranca.jhtml).
Be sure to add the rspec-rails gem to your Gemfile and then create a dummy test app for the specs to run against.

    $ bundle exec rake test app
    $ bundle exec rspec spec

Copyright (c) 2012-2014 João Netto, released under the New BSD License
