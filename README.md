analects.rb
===========

[![Build Status](https://travis-ci.org/plexus/analects.png)](https://travis-ci.org/lexus/analects)

Public datasets on the Chinese language, accessible from Ruby

## Download the data

With Rake

```ruby
# Rakefile
require 'analects/rake_tasks'

Analects::RakeTasks.new do |analects|
  analects.data_dir '/tmp/analects' # defaults to ~/.analects
end
```

```sh
rake analects:retrieve:all        # download all sources
rake analects:retrieve:cedict     # download CC-CEDICT
rake analects:retrieve:chise_ids  # download Chise-IDS
```

Or from Ruby

```ruby
analects = Analects::Library.new(data_dir: '/tmp/analects')
analects.cedict.retrieve
analects.chise_ids.retrieve
```

## Use the data

```
analects = Analects::Library.new(data_dir: '/tmp/analects')
analects.cedict.take(3)
# => [["AA制", "AA制", "A A zhi4", "/to split the bill/to go Dutch/"], ["A咖", "A咖", "A ka1", "/class \"A\"/top grade/"], ["A片", "A片", "A pian4", "/adult movie/pornography/"]]

analects.chise_ids.to_a.sample(3)
# [["U+59BF", "妿", "⿱加女"], ["U-0002441B", "𤐛", "⿰火閙"], ["U+83A1", "莡", "⿱艹足"]]
```
