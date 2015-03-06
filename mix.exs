defmodule ChineseTranslation.Mixfile do
  use Mix.Project

  def project do
    [app: :chinese_translation,
     version: "0.1.0",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps,
   ]
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
      {:httpoison, "~> 0.6"},
    ]
  end

  defp description do
    """
    ChineseTranslation provides traditional chinese <-> simplified chinese translation, as well as pinyin translation and slugify for chinese phrases/characters.
    """
  end

  defp package do
    [
      files: ["lib", "data", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      contributors: ["Tyr Chen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tyrchen/chinese_translation"}
   ]
  end
end
