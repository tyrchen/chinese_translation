defmodule ChineseTranslation.Pinyin do
  @moduledoc """
  Read the word/character -> pinyin file and generate
  functions for matching
  """

  alias ChineseTranslation.Pinyin.Util

  IO.puts "Max word length used by compilation: #{Util.max_word_len}"
  Util.get_pinyin_data
  |> Stream.with_index
  |> Stream.map(fn({{ch, pinyin}, index}) -> 
    if rem(index, 1000) == 0, do: IO.puts "processing: #{index} #{ch}"

    def process(unquote(ch) <> rest) do
      unquote(:binary.bin_to_list(pinyin <> " ")) ++ process(rest)
    end
  end)
  |> Enum.to_list

  def process(<<ch, rest :: binary>>) do
    [ch|process(rest)]
  end

  def process("") do
    []
  end
end
