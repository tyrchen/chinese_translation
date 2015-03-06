defmodule ChineseTranslation.Slugify do
  @moduledoc """
  Read the pinyin tone file and generate functions to 
  normalize the tone
  """
  alias ChineseTranslation.Pinyin.Util

  IO.puts "Processing pinyin tones"
  Util.get_tone_data
  |> Stream.map(fn({pinyin, ascii, tone}) ->
    defp process(unquote(pinyin) <> rest, _acc) do
      unquote(:binary.bin_to_list(ascii)) ++ process(rest, unquote(tone))
    end
  end)
  |> Enum.to_list

  defp process(<<ch, rest :: binary>>, acc) do
    [ch|process(rest, acc)]
  end

  defp process("", acc) do
    :binary.bin_to_list(acc)
  end

  def process(content) do
    process(content, "") |> IO.iodata_to_binary
  end
 
end
