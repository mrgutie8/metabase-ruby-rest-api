# Metabase Ruby Client

Ruby client library for Metabase API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metabase'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install metabase
```

## Usage

### Authentication

```ruby
client = Metabase::Client.new(
  url: 'https://example.com',
  username: 'mb@example.com',
  password: 'p@ssw0rd'
)

# Authenticate
client.login

# Fetch the current user
client.current_user
```

Or specify valid session token:

```ruby
client = Metabase::Client.new(
  url: 'https://example.com',
  token: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
)

client.current_user
```

### Query results

```ruby
# Fetch query results of the card
card_id = 1
client.query_card(card_id)

# Specify export format (csv, json, xlsx)
client.query_card(card_id, format: :csv)

# Fetch query results of the public card
card_uuid = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
client.query_public_card(card_uuid)
client.query_public_card(card_uuid, format: :csv)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

When adding a new endpoint, run `docker-compose up` to start a local Metabase and run `rake spec`. Commit Metabase database to the repository as well.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

As of 11/09/2023 the vcr testing framework has been fully depreciated meaning VCR test will no longer work. 
Existing VCR tests have been removed and replaced with Webmocks.

To write a unit test for a new endpoint refer to the Webmock and Metabase API documentation found at the following URLs:

https://www.rubydoc.info/gems/webmock/3.18.1

https://www.metabase.com/docs/latest/api-documentation

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shimoju/metabase-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
