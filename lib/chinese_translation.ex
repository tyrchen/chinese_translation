defmodule ChineseTranslation do
  alias ChineseTranslation.Translation, as: Trans
  alias ChineseTranslation.Pinyin
  alias ChineseTranslation.Slugify
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
  def translate(content), do: content |> Trans.do_t2s |> IO.iodata_to_binary
  def translate(content, :s2t), do: content |> Trans.do_s2t |> IO.iodata_to_binary

  @doc ~S"""
  Public function to convert Chinese words to pinyin. Example:
  
      iex> ChineseTranslation.pinyin("我是中国人")
      "wǒ shì zhōng guó rén"

      iex> ChineseTranslation.pinyin("我是中國人", :trad)
      "wǒ shì zhōng guó rén"
  
  """
  def pinyin(content, :trad), do: content |> translate |> pinyin

  def pinyin(content) do
    content
    |> Pinyin.process
    |> IO.iodata_to_binary
    |> String.rstrip
  end


  @doc ~S"""
  Public function to slugify Chinese words. Example:
  
      iex> ChineseTranslation.slugify("我是中国人")
      "wo-shi-zhong-guo-ren"

      iex> ChineseTranslation.slugify("我是中國人", [:trad, :tone])
      "wo3-shi4-zhong1-guo2-ren2"

      iex> ChineseTranslation.slugify(" *& 我是46 848 中 ----- 国人")
      "wo-shi-zhong-guo-ren"
 
  """
  def slugify(content), do: content |> pinyin |> to_slug
  def slugify(content, [:pinyin]), do: content |> to_slug
  def slugify(content, [:pinyin, :tone]), do: content |> to_slug(true)
  def slugify(content, [:tone, :pinyin]), do: slugify(content, [:pinyin, :tone])
  def slugify(content, [:trad]), do: content |> pinyin(:trad) |> to_slug
  def slugify(content, [:tone]), do: content |> pinyin |> to_slug(true)
  def slugify(content, [:trad, :tone]), do: content |> pinyin(:trad) |> to_slug(true)
  def slugify(content, [:tone, :trad]), do: slugify(content, [:trad, :tone])

  defp to_slug(data, with_tone \\ false) do
    data
    |> String.split
    |> Stream.map(&(normalize_slug(&1, with_tone)))
    |> Enum.join(" ")
    |> String.replace(~r/[^a-z1-4]+/, "-")
    |> String.strip(?-)
  end

  defp normalize_slug(content, with_tone) do
    slug = content |> Slugify.process
    case with_tone do
      true -> slug
      false -> Regex.replace(~r/[1-4]/, slug, "")
    end
  end

end
