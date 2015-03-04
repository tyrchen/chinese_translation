defmodule ChineseTranslation.Util do
  @moduledoc """
  Utility functions to read data/conversion.txt file and parse it to a hash dict.
  """

  @filename "data/conversion.txt"
  @php_regex ~r/\$(?<name>\S+).*\((?<content>[^\)]+)\)/
  @php_kv ~r/'(?<key>[^']+)'\s*=>\s*'(?<value>[^']+)'/

  def get_trans_data do
    @filename
    |> File.read!
    |> match
    |> Enum.map(fn([_whole, name, content]) -> 
      {name, parse(content)}
    end)
    |> Enum.into(%{})
  end

  defp match(content) do
    Regex.scan @php_regex, content
  end
  
  defp parse(content) do
    Regex.scan(@php_kv, content)
    |> Enum.map(fn([_whole, key, value]) -> 
      {key, value}
    end)
    |> sort
  end

  defp sort(data) do
    data |> Enum.sort(fn({k1, _}, {k2, _}) -> 
      String.length(k1) > String.length(k2)  
    end)
  end

  # for debug purpose - to see how the parsed file is
  def to_files do
    get_trans_data
    |> Enum.map(&to_file/1)
  end

  defp to_file({name, data}) do
    content = data
              |> Enum.map(fn({k, v}) ->
                "#{k}: #{v}"
              end)
              |> Enum.join("\n")
    File.write!("data/#{name}.txt", content)
  end
end
