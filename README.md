# AbleSetup

AbleSetup copies a setup script and rubocop rules to a Rails project.
It also injects the rubocop command into the precommit hook.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'able_setup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install able_setup

## Usage

Execute the generator command to copy the files:

    $ bundle exec rails generate able_setup:install

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/able_setup.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
