defmodule ChineseTranslation do
  @moduledoc """
  this module only utilize zh2Hant to do translation from simplified chinese 
  to traditional chinese, and vise versa.
  """

  @doc ~S"""
  Public function to do Chinese translation. Example:
  
      iex> ChineseTranslation.translate("我是中国人", :s2t)
      "我是中國人"

      iex> ChineseTranslation.translate("我是中國人")
      "我是中国人"
  
  """
  def translate(content, direction \\ :t2s) do
    case direction do
      :t2s -> content |> do_t2s |> IO.iodata_to_binary
      :s2t -> content |> do_s2t |> IO.iodata_to_binary
      _    -> nil
    end
  end

  ChineseTranslation.Util.get_trans_data["zh2Hant"]
  |> Enum.map(fn({simp, trad}) -> 
    defp do_t2s(unquote(trad) <> rest) do
      unquote(:binary.bin_to_list(simp)) ++ do_t2s(rest)
    end

    defp do_s2t(unquote(simp) <> rest) do
      unquote(:binary.bin_to_list(trad)) ++ do_s2t(rest)
    end
  end)

  defp do_t2s(<<ch, rest :: binary>>) do
    [ch|do_t2s(rest)]
  end

  defp do_s2t(<<ch, rest :: binary>>) do
    [ch|do_s2t(rest)]
  end

  defp do_t2s("") do
    []
  end

  defp do_s2t("") do
    []
  end
end
