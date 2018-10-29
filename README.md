# IdGenerator

[![Build Status](https://travis-ci.org/matic-insurance/id_generator.svg?branch=master)](https://travis-ci.org/matic-insurance/id_generator)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/ff827f62fb034d3b8ff71d69a9f0e233)](https://www.codacy.com/app/Matic/id_generator?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=matic-insurance/id_generator&amp;utm_campaign=Badge_Grade)

This gem provides uniq and random ids generation in distributed services 
but at the same time gives some ordering (timestamp) and debug (context) information

The gem is inspired by [Twitter Snowflake](https://github.com/twitter-archive/snowflake/tree/snowflake-2010) and other algorithms.

The main difference is that ids generated by gem are not fully sequenced. 
We want to have large random part that can be used as a simple guard against enumeration attack.

## Goals & Assumptions

While we designed format and gem we used these as requirements:

-   Every system should be able to independently (without coordination) generate id that will never (with reasonable chances) be duplicated
-   ID allows partial time ordering (timestamp in seconds)
-   ID has easy system identifier (context)
-   ID is human readable 
-   ID size is not a concern
-   ID format should not be used for business/application logic - thus it remains flexible for future changes

## ID Format

Suggested algorithm is based on the Twitter snowflake and other similar alghorithms:

`TTTTTTTT-II-RRRRRRRRRRRRRRRRRRRRRR`

-   `TTTTTTTT` - time in seconds since 2000 (just cool number) represented as hex - Gives us ~150 years of uniq sequences
-   `II` - 1 byte for System Identification in hex
-   `RRRRRRRRRRRRRRRRRRRRRR` - 11 bytes secure random number as hex

Code to generate is pretty straightforward: 

```ruby
time = format('%08x', Time.now.to_i - Time.new(2000).to_i)
id = '6a'
random = SecureRandom.hex(11)
id = "#{time}-#{id}-#{random}" # "21dc3680-6a-910df0665e5e29b9f89e21"
```

## Installation

Add gem to your application's Gemfile:

```ruby
gem 'id_generator'
```

## Usage

```ruby
# Somewhere during project start
context_id = 165 # value from 0 to 255
IdGenerator.configuration.context_id = context_id
# Or using block
IdGenerator.configure { |config| config.context_id = context_id } 

#Inside of the actual code
IdGenerator.generate
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/matic-insurance/id_generator]().

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
