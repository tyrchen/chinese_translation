defmodule ChineseTranslation.Translation.Util do
  @moduledoc """
  Utility functions to read s2t_conversion.txt file and parse it into a list
  ordered by the length of the words.
  """

  @filename Path.join([__DIR__, "..", "..", "data", "s2t_conversion.txt"])
  @php_regex ~r/\$(?<name>\S+).*\((?<content>[^\)]+)\)/
  @php_kv ~r/'(?<key>[^']+)'\s*=>\s*'(?<value>[^']+)'/

  def get_trans_data do
    @filename
    |> get_file_content
    |> match
    |> Enum.map(fn [_whole, name, content] ->
         {name, parse(content)}
       end)
    |> Enum.into(%{})
  end

  defp get_file_content(filename) do
    case File.read(filename) do
      # silently do nothing
      {:error, _} ->
        ""

      {:ok, content} ->
        content
    end
  end

  defp match(content) do
    Regex.scan(@php_regex, content)
  end

  defp parse(content) do
    @php_kv
    |> Regex.scan(content)
    |> Enum.map(fn [_whole, key, value] ->
         {key, value}
       end)
    |> sort
  end

  defp sort(data) do
    data
    |> Enum.sort(fn {k1, _}, {k2, _} ->
         String.length(k1) > String.length(k2)
       end)
  end

  # for debug purpose - to see how the parsed file is
  def to_files, do: Enum.map(get_trans_data(), &to_file/1)

  defp to_file({name, data}) do
    content =
      data
      |> Enum.map(fn {k, v} ->
           "#{k}: #{v}"
         end)
      |> Enum.join("\n")

    File.write!("data/#{name}.txt", content)
  end
end
