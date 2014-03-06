# Purpose

Load and dump quandl data format.


# Installation

```ruby
gem 'quandl_format'
```


# Configuration

Add this to your Rakefile:

```ruby
require 'quandl/format'
```


# Usage


### Load

```ruby
# open a file
file = File.open("spec/fixtures/data/annual.qdf")
# read each line of the file until a dataset node has been built
# pass each dataset node to the block for manipulation
Quandl::Format::Dataset.each_line(file) do |dataset|
  puts "full_code: #{dataset.full_code}"
  puts "first_line_of_data: #{dataset.data.first.to_s}"
end
```


### Dump

```ruby
# load the file as a collection of Dataset instances
datasets = Quandl::Format::Dataset.load_from_file("spec/fixtures/data/annual.qdf")
# make some changes
dataset = datasets.first
dataset.code = 'NEW_CODE'
# dump the collection as QDF
puts Quandl::Format::Dataset.dump( [dataset] )
```


