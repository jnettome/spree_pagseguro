# Spree Pagseguro (Brazilian Gateway)

Add support for Pagseguro checkout as a payment method.
__Only tested on spree 2.1.3__

## Installation

1. Add the following to your Gemfile

<pre>
    gem 'spree_pagseguro', github: 'jnettome/spree_pagseguro'
</pre>

2. Run `bundle install`

3. To copy and apply migrations run: `rails g spree_skrill:install`

## Configuring

1. Add a new Payment Method, using: `BillingIntegration::Pagseguro::Checkout` as the `Provider`

2. Click `Create`, and enter your Store's Pagseguro Email and Token in the fields provided.

3. `Save` and enjoy!


Testing
-------

Be sure to add the rspec-rails gem to your Gemfile and then create a dummy test app for the specs to run against.

    $ bundle exec rake test app
    $ bundle exec rspec spec

Copyright (c) 2012-2014 João Netto, released under the New BSD License
