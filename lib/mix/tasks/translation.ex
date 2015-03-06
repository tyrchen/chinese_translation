defmodule Mix.Tasks.ChineseTranslation do
  use Mix.Task

  @shortdoc "get the latest version of the translation table and recompile myself"

  @urls [{
    "http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3/includes/ZhConversion.php",
    "s2t_conversion.txt"
  },{
    "https://raw.githubusercontent.com/janx/ruby-pinyin/master/lib/ruby-pinyin/data/words.dat",
    "pinyin_words.txt"
  },{
    "https://raw.githubusercontent.com/janx/ruby-pinyin/master/lib/ruby-pinyin/data/Mandarin.dat",
    "pinyin_characters.txt"
  }]

  @name "chinese_translation"
  @mod_path "data"
  @dep_path "deps/#{@name}/#{@mod_path}"
  @beam_path "_build/dev/lib/#{@name}"

  def run(_args) do
    HTTPoison.start
    get_data_file(@urls)
    clean_beam(@beam_path)
    recompile()
  end

  defp get_data_file(urls) do
    urls
    |> Stream.map(&download/1)
    |> Stream.map(&write_file/1)
    |> Enum.to_list
  end

  defp clean_beam(beam_path) do
    IO.puts "Cleaning #{beam_path}..."
    File.rm_rf(beam_path)
  end

  defp recompile do
    IO.puts "Recompiling chinese_translation..."
    System.cmd("mix", ["compile"])
  end

  defp download({url, filename}) do
    IO.puts "Downloading from #{url}..."
    %HTTPoison.Response{body: body} = HTTPoison.get! url
    {filename, body}
  end

  def write_file({filename, body}) do
    case File.exists? @dep_path do
      true -> Path.join(@dep_path, filename)
      _    -> Path.join(@mod_path, filename)
    end
    |> File.write(body)
  end
end
