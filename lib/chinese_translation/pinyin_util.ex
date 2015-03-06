defmodule ChineseTranslation.Pinyin.Util do
  @moduledoc """
  Utility functions to read pinyin_characters.txt / pinyin_words.txt and parse
  it into a list ordered by the length of the words.
  """
  alias ChineseTranslation.Iterable

  @path Path.join([__DIR__, "..", "..", "data"])
  # the order is very important here
  @files ["pinyin_characters.txt", "pinyin_words.txt"]
  @tone_file "pinyin_tone.txt"

  def get_pinyin_data do
    @files
    |> Enum.reduce([], &(parse(&1) ++ &2))
  end

  def get_tone_data do
    @tone_file
    |> parse
  end

  def max_word_len do
    # this is to avoid atom exceed - after all, the whole
    # words are > 200, 000
    (System.get_env("MAX_WORD_LEN") || "2") |> String.to_integer
  end

  def parse("pinyin_words.txt" = filename) do
    filename
    |> get_file_stream
    |> Stream.map(&(split(&1, ",")))
    |> Iterable.filter_by(:item_size, :eq, 2) # after split, items should be 2
    |> Iterable.filter_by(:key_len, :lte, max_word_len)
    |> Iterable.sort_by(:key_len, :desc)
  end

  def parse("pinyin_characters.txt" = filename) do
    filename
    |> get_file_stream
    |> Stream.map(&(normalize_character_conversion(&1)))
    |> Enum.to_list
  end

  def parse("pinyin_tone.txt" = filename) do
    filename
    |> get_file_stream
    |> Stream.map(&(split(&1, ",")))
    |> Iterable.sort_by(:key_len, :desc)
  end

  defp get_file_stream(filename) do
    Path.join(@path, filename)
    |> File.stream!
  end

  defp split(line, sep \\ " ") do
    line
    |> String.strip
    |> String.split(sep)
    |> Enum.map(&(String.strip(&1)))
    |> List.to_tuple
  end

  defp normalize_character_conversion(line) do
    {string_code, pinyin} = split(line)
    char = << String.to_integer(string_code, 16) :: utf8 >>
    # TODO: tchen figure out how to fix this Thu Mar  5 10:37:24 2015
    # so far for character with multiple pinyin, if it doesn't have word context
    # we don't know which pinyin to use. So we just use the first one as a 
    # workaround.
    data = split(pinyin, ",") |> elem(0)
    {char, data}
  end
end
