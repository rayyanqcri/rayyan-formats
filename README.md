[![Build Status](https://travis-ci.org/rayyansys/rayyan-formats.svg?branch=master)](https://travis-ci.org/rayyansys/rayyan-formats)
[![Coverage Status](https://coveralls.io/repos/github/rayyansys/rayyan-formats/badge.svg?branch=master)](https://coveralls.io/github/rayyansys/rayyan-formats?branch=master)

# RayyanFormats

This gem offers a command line utility to convert between different reference file
formats defined using plugins in the `RayyanFormats::Plugins` namespace.
This is a list of known gems that offer such plugins:
- [rayyan-formats-core](https://github.com/rayyansys/rayyan-formats-core)
- [rayyan-formats-plugins](https://github.com/rayyansys/rayyan-formats-plugins)
- [rayyan-scrapers](https://github.com/rayyansys/rayyan-scrapers)

It can also be used as a single gem dependency when working with RayyanFormats.

## Installation

Add this line to your application's Gemfile:

    gem 'rayyan-formats'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rayyan-formats

## Usage

### Command line usage

To convert a Refman file to EndNote text:

    $ rayyan-formats-convert input.ris output.enw

You can even combine multiple input files and convert them to a single output file:

    $ rayyan-formats-convert input1.ris input2.csv input3.ciw output.enw

### Ruby usage

    args = %w(input1.ris output.enw)
    begin
      RayyanFormats::Command.new(args).run
    rescue => e
      # problem in conversion
      puts e.message
    end

## Development and Testing

To build for local development and testing (requires Docker):

```bash
docker build . -t rayyan-formats:1
```

To run the tests:

```bash
docker run -it --rm -v $PWD:/home rayyan-formats:1
```

This will allow you to edit files and re-run the tests without rebuilding
the image.

## Publishing the gem

```bash
docker build . -t rayyan-formats:1
docker run -it --rm rayyan-formats:1 /home/publish.sh
```

Enter your email and password when prompted. If you want to skip interactive
login, supply `RUBYGEMS_API_KEY` as an additional argument:

```bash
docker run -it --rm -e RUBYGEMS_API_KEY=YOUR_RUBYGEMS_API_KEY rayyan-formats:1 /home/publish.sh
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
