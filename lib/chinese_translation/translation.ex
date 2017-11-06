defmodule ChineseTranslation.Translation do
  @moduledoc """
  Generate a set of translation functions
  """
  alias ChineseTranslation.Translation.Util

  Util.get_trans_data()
  |> Map.get("zh2Hant", [])
  |> Enum.map(fn {simp, trad} ->
       def do_t2s(unquote(trad) <> rest) do
         unquote(:binary.bin_to_list(simp)) ++ do_t2s(rest)
       end

       def do_s2t(unquote(simp) <> rest) do
         unquote(:binary.bin_to_list(trad)) ++ do_s2t(rest)
       end
     end)

  def do_t2s(<<ch, rest::binary>>) do
    [ch | do_t2s(rest)]
  end

  def do_t2s("") do
    []
  end

  def do_s2t(<<ch, rest::binary>>) do
    [ch | do_s2t(rest)]
  end

  def do_s2t("") do
    []
  end
end
