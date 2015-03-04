ChineseTranslation
==================

Elixir module to translate between traditional chinese and simplified chinese, based on [wikipedia's latest translation data](http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3/includes/ZhConversion.php).

This module is highly encouraged by Elixir unicode module, to read the entire translation meta data from file, and generate the desired functions for pattern matching.

## Installation

First, add ChineseTranslation to your `mix.exs` dependencies:

```elixir
def deps do
  [{:chinese_translation, github: "tyrchen/chinese_translation"}]
end
```

and run `$ mix deps.get; mix compile`.

Then you shall be able to run the mix task to download the latest translation file:

```bash
$ mix chinese_translation
```

The downloaded file will be put into `deps/chinese_translation/conversion.txt` and the whole module will be recompiled.

Note that the first compilation and each `mix chinese_translation` are quite time consuming (it takes up to a minute since around ~10,000 functions are generated at compilation time), so be patient!

## Usage

ChineseTranslation is very easy to use, as follows:

```iex
iex> ChineseTranslation.translate("我是中国人", :s2t)
"我是中國人"
iex> ChineseTranslation.translate("我是中國人")
"我是中国人"
```

## Performance

If you installed [benchfella](https://github.com/alco/benchfella). You could test the performance of this module in your system. Below is a general benchmark result.

```bash
$ mix bench
Settings:
  duration:      1.0 s
  mem stats:     false
  sys mem stats: false

[22:00:52] 1/4: ChineseTranslationBench.translate a character t->s
[22:00:55] 2/4: ChineseTranslationBench.translate a 158-character sentence s->t
[22:00:57] 3/4: ChineseTranslationBench.translate a character s->t
[22:00:59] 4/4: ChineseTranslationBench.translate a 158-character sentence t->s
Finished in 8.85 seconds

ChineseTranslationBench.translate a character t->s:                10000000   0.25 µs/op
ChineseTranslationBench.translate a character s->t:                10000000   0.25 µs/op
ChineseTranslationBench.translate a 158-character sentence s->t:     100000   14.56 µs/op
ChineseTranslationBench.translate a 158-character sentence t->s:     100000   14.71 µs/op
```
## License

    Copyright © 2015-2016 Tyr Chen <tchen@toureet.com>

    This work is free. You can redistribute it and/or modify it under the
    terms of the MIT License. See the LICENSE file for more details.
