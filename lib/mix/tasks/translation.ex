defmodule Mix.Tasks.ChineseTranslation do
  use Mix.Task

  @shortdoc "get the latest version of the translation table and recompile myself"

  @moduledoc """
  
  """

  @url "http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3/includes/ZhConversion.php"
  @path "conversion.txt"
  def run(_args) do
    HTTPoison.start
    %HTTPoison.Response{body: body} = HTTPoison.get! @url
    File.write! @path, body
  end
end
