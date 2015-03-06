ChineseTranslation
==================

This module provides three core functionalities related with chinese translation:

1. Translate tranditional chinese to simplified chinese, or vise versa. It is based on [wikipedia's latest translation data](http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3/includes/ZhConversion.php).
2. Translate Chinese words to pinyin. It is based on the data collected by [janx/ruby-pinyin](https://github.com/janx/ruby-pinyin).
3. Slugify Chinese words (or pinyin).

This module is highly encouraged by Elixir unicode module, to read the translation meta data from file, and generate the desired functions for pattern matching.

## Installation

First, add ChineseTranslation to your `mix.exs` dependencies:

```elixir
def deps do
  [{:chinese_translation, github: "tyrchen/chinese_translation"}]
end
```

and run `$ mix deps.get` to get the dependencies.

Then you could compile the module by `mix compile`. Note that it will compile over 133, 000 functions by default (compile all the 2-char phrases and 1-char chanracters). The compilation time is around 30 minutes. So be patient! You can set environment variable `MAX_WORD_LEN` to tune the compilation:

```bash
$ MAX_WORD_LEN=1 mix compile   # this will compile around 40, 000 functions
```

If later you found the translation files has changed, you can run the following mix task to download the latest translation files:

```bash
$ mix chinese_translation
```

The downloaded file will be put into `deps/chinese_translation/data` and the whole module will be recompiled.

## Usage

ChineseTranslation is very easy to use, as follows:

### Translation

```iex
iex> ChineseTranslation.translate("我是中国人", :s2t)
"我是中國人"

iex> ChineseTranslation.translate("我是中國人")
"我是中国人"
```

### Pinyin (note the polyphone)

```iex
iex> ChineseTranslation.pinyin("长工长大以后")
"cháng gōng zhǎng dà yǐ hòu"

iex> ChineseTranslation.pinyin("長工長大以後", :trad)
"cháng gōng zhǎng dà yǐ hòu"
```

### Slugify (also the polyphone)

For slugify you could choose to use 

```iex
iex> ChineseTranslation.slugify("长工长大以后")
"chang-gong-zhang-da-yi-hou"

iex> ChineseTranslation.slugify("长工长大以后", [:tone])
"chang2-gong1-zhang3-da4-yi3-hou4"

iex> ChineseTranslation.slugify("長工長大以後", [:trad, :tone])
"chang2-gong1-zhang3-da4-yi3-hou4"

iex> ChineseTranslation.slugify(" *& 我是46 848 中 ----- 国人")
"wo-shi-zhong-guo-ren"
```

You can explore more examples in the `test`.

## Performance

If you installed [benchfella](https://github.com/alco/benchfella). You could test the performance of this module in your system. Below is a general benchmark result.

```bash
$ mix bench
Settings:
  duration:      1.0 s
  mem stats:     false
  sys mem stats: false

[20:49:22] 1/8: ChineseTranslationBench.translate a character t->s
[20:49:25] 2/8: ChineseTranslationBench.translate 158-character chinese to pinyin
[20:49:28] 3/8: ChineseTranslationBench.translate a 158-character sentence s->t
[20:49:30] 4/8: ChineseTranslationBench.slugify pinyin with tone
[20:49:32] 5/8: ChineseTranslationBench.slugify pinyin
[20:49:36] 6/8: ChineseTranslationBench.translate a character s->t
[20:49:39] 7/8: ChineseTranslationBench.translate a 158-character sentence t->s
[20:49:41] 8/8: ChineseTranslationBench.slugify a short sentence
Finished in 23.25 seconds

ChineseTranslationBench.translate a character t->s:                  10000000   0.28 µs/op
ChineseTranslationBench.translate a character s->t:                  10000000   0.29 µs/op
ChineseTranslationBench.translate a 158-character sentence t->s:       100000   16.78 µs/op
ChineseTranslationBench.translate a 158-character sentence s->t:       100000   16.87 µs/op
ChineseTranslationBench.slugify pinyin with tone:                       50000   32.59 µs/op
ChineseTranslationBench.translate 158-character chinese to pinyin:      50000   45.07 µs/op
ChineseTranslationBench.slugify pinyin:                                 50000   66.96 µs/op
ChineseTranslationBench.slugify a short sentence:                       50000   69.64 µs/op
```
## License

    Copyright © 2015-2016 Tyr Chen <tchen@toureet.com>

    This work is free. You can redistribute it and/or modify it under the
    terms of the MIT License. See the LICENSE file for more details.
