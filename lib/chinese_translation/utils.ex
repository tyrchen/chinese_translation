defmodule ChineseTranslation.Utils do
  @moduledoc """
  utility functions
  """
  def data_path do
    :chinese_translation
    |> Application.app_dir()
    |> Path.join("priv")
  end
end
