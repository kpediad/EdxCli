# EdxCli

Welcome to EdxCli! This is a ruby based CLI application/gem that was developed as part of an assignment. It uses [Watir](http://watir.com/) and nokogiri to scrape the [EdX](https://www.edx.org/course/?program=all&availability=starting_soon) starting soon programs and present them to the user through the console. Additionally, the user has the ability to drill down on each of the programs presented to view the courses contained in each.

Please note that the use of Watir slows things down considerably, however no unnecessary web accesses are performed unless absolutely required. Have fun!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'EdxCli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install EdxCli

Moreover you need [mozilla/geckodriver](https://github.com/mozilla/geckodriver/releases) installed on your machine for this application/gem to work. Go to the above website and download the latest release for your operating system, extract and add the driver to your PATH so that it can be accessed by other tools. You may need to grant execution permission rights for the extracted file.

## Usage

From within the `EdxCli` directory type the following command to run the application:

    `$ ./bin/EdxCli`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'kpediad'/EdxCli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EdxCli project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'kpediad'/EdxCli/blob/master/CODE_OF_CONDUCT.md).
