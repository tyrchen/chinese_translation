defmodule ChineseTranslation.Mixfile do
  use Mix.Project

  def project do
    [app: :chinese_translation,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.6", only: [:dev, :test]},
    ]
  end
end
