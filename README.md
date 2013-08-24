analects.rb
===========

[![Gem Version](https://badge.fury.io/rb/analects.png)][gem]
[![Build Status](https://secure.travis-ci.org/plexus/analects.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/plexus/analects.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/plexus/analects.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/plexus/analects/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/analects
[travis]: https://travis-ci.org/plexus/analects
[gemnasium]: https://gemnasium.com/plexus/analects
[codeclimate]: https://codeclimate.com/github/plexus/analects
[coveralls]: https://coveralls.io/r/plexus/analects

Public datasets on the Chinese language, accessible from Ruby

## Download the data

With Rake

```ruby
# Rakefile
require 'analects/rake_tasks'

Analects.init_rake_tasks do
  data_dir '/tmp/analects' # defaults to ~/.analects

  task :import_cedict do
    library.cedict.each do |entry|
      # ..
    end
  end
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
