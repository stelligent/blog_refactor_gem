# BlogGem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/blog_refactor_gem`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blog_refactor_gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blog_refactor_gem

## Usage

The steps we present here represent a continuous delivery (CD) build pipeline to an acceptance environment. In general terms this would be called a 'build' pipeline. This repository represents a _framework_ for providing classes and methods specific to your organization's canonical build pipeline. (None of these steps is intended to be an exhaustive qualification of a VCS revision's readiness for deployment to a production-like environment!)

### commit phase
- scm-polling *
- static-analysis *
- unit-testing

### acceptance phase
- app_prerequisites *
- app_deployment *
- automated-testing *


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/blog_refactor_gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
