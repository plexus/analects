analects.rb
===========

[![Build Status](https://travis-ci.org/plexus/analects.png)](https://travis-ci.org/lexus/analects)

Public datasets on the Chinese language, accessible from Ruby

Download the data

```
rake analects:retrieve:cedict
rake analects:retrieve:cc-cedict
```

Use the data

```
Analects::Sources.cedict.take(3)
# => [["AA制", "AA制", "A A zhi4", "/to split the bill/to go Dutch/"], ["A咖", "A咖", "A ka1", "/class \"A\"/top grade/"], ["A片", "A片", "A pian4", "/adult movie/pornography/"]]

Analects::Sources.chise_ids.to_a.sample(3)
# [["U+59BF", "妿", "⿱加女"], ["U-0002441B", "𤐛", "⿰火閙"], ["U+83A1", "莡", "⿱艹足"]]
```

All code (c) Arne Brasseur, 2012-2013. Analects is released under the MIT License (http://www.opensource.org/licenses/mit-license.php).
