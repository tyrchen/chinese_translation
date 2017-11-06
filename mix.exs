defmodule ChineseTranslation.Mixfile do
  use Mix.Project

  @version File.cwd!() |> Path.join("version") |> File.read!() |> String.trim()

  def project do
    [
      app: :chinese_translation,
      version: @version,
      elixir: "~> 1.5",
      description: description(),
      package: package(),
      deps: deps()
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
      {:httpoison, "~> 0.13"},

      # dev & test
      {:benchfella, "~> 0.3.5", only: [:dev]},
      {:credo, "~> 0.8", only: [:dev, :test]},
      {:ex_doc, "~> 0.18.1", only: [:dev, :test]},
      {:pre_commit_hook, "~> 1.0.6", only: [:dev]}
    ]
  end

  defp description do
    """
    ChineseTranslation provides traditional chinese <-> simplified chinese translation, as well as pinyin translation and slugify for chinese phrases/characters.
    """
  end

  defp package do
    [
      files: ["lib", "data", "mix.exs", "README*", "LICENSE*"],
      contributors: ["Tyr Chen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tyrchen/chinese_translation"}
    ]
  end
end
