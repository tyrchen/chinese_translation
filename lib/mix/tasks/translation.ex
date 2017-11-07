defmodule Mix.Tasks.ChineseTranslation do
  @moduledoc """
  The task for loading latest data from wikipedia.
  """
  use Mix.Task
  alias ChineseTranslation.Utils

  @shortdoc "get the latest version of the translation table and recompile myself"

  @urls [
    {
      "http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3/includes/ZhConversion.php",
      "s2t_conversion.txt"
    },
    {
      "https://raw.githubusercontent.com/janx/ruby-pinyin/master/lib/ruby-pinyin/data/words.dat",
      "pinyin_words.txt"
    },
    {
      "https://raw.githubusercontent.com/janx/ruby-pinyin/master/lib/ruby-pinyin/data/Mandarin.dat",
      "pinyin_characters.txt"
    }
  ]

  def run(_args) do
    HTTPoison.start()
    get_data_file(@urls)
    recompile()
  end

  defp get_data_file(urls) do
    urls
    |> Stream.map(&download/1)
    |> Stream.map(&write_file/1)
    |> Enum.to_list()
  end

  defp recompile do
    IO.puts("Recompiling chinese_translation...")
    System.cmd("mix", ["clean"])
    System.cmd("mix", ["compile"])
  end

  defp download({url, filename}) do
    IO.puts("Downloading from #{url}...")
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    {filename, body}
  end

  def write_file({filename, body}) do
    path = Path.join(Utils.data_path(), filename)
    File.write(path, body)
  end
end
