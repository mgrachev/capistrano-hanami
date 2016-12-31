# Capistrano::Hanami

[Hanami](https://github.com/hanami/hanami) tasks for [Capistrano](https://github.com/capistrano/capistrano) v3:

  - `cap deploy:migrate`
  - `cap deploy:compile_assets`

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'capistrano', '~> 3.7'
  gem 'capistrano-hanami'
end
```

And then execute:

    $ bundle

Then run the generator to create a basic set of configuration files:

    $ bundle exec cap install

## Usage

```ruby
# Capfile
require 'capistrano/hanami' # It also requires bundler
```

You can tweak some Hanami-specific options in `config/deploy.rb`:

```ruby
# If the environment differs from the stage name
set :hanami_env, 'staging'

# Defaults to :app role
set :migration_role, :db

# Defaults to the primary :app server
set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrations were not modified
set :conditionally_migrate, true

# Defaults to [:web]
set :assets_roles, [:web, :app]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/capistrano-hanami.

