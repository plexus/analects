analects.rb
===========

[![Gem Version](https://badge.fury.io/rb/analects.png)][gem]
[![Build Status](https://secure.travis-ci.org/plexus/analects.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/plexus/analects.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/plexus/analects.png)][codeclimate]

[gem]: https://rubygems.org/gems/analects
[travis]: https://travis-ci.org/plexus/analects
[gemnasium]: https://gemnasium.com/plexus/analects
[codeclimate]: https://codeclimate.com/github/plexus/analects

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
rake analects:download:all        # download all sources
rake analects:download:cedict     # download CC-CEDICT
rake analects:download:chise_ids  # download Chise-IDS
rake analects:download:hsk        # download HSK data
rake analects:download:unihan     # download Unihan database
```

Or from Ruby

```ruby
analects = Analects::Library.new(data_dir: '/tmp/analects')
analects.cedict.retrieve
analects.chise_ids.retrieve
```

## Use the data

```ruby
analects = Analects::Library.new(data_dir: '/tmp/analects')
analects.cedict.take(3)
# => [["AA制", "AA制", "A A zhi4", "/to split the bill/to go Dutch/"], ["A咖", "A咖", "A ka1", "/class \"A\"/top grade/"], ["A片", "A片", "A pian4", "/adult movie/pornography/"]]

analects.chise_ids.to_a.sample(3)
# [["U+59BF", "妿", "⿱加女"], ["U-0002441B", "𤐛", "⿰火閙"], ["U+83A1", "莡", "⿱艹足"]]
```

## Other stuff

Analects wraps RMMSeg for easy segmenting of Chinese text

```ruby
Analects::Tokenizer.new.tokenize("为待那个朋友拿哟出来，咿呀噢哎…")
# => ["为", "待", "那个", "朋友", "拿", "哟", "出来", "，", "咿", "呀", "噢", "哎", "…"]
```

If you have Chinese text in GB or BIG5 encoding, you can do stuff like this

```ruby
Analects::Encoding.valid_cjk(str)
Analects::Encoding.from_gb(str)   # returns UTF-8
Analects::Encoding.from_big5(str) # returns UTF-8
```

## License

Copyright ⓒ Arne Brasseur 2012-2014

Licensed as GPL-v3
