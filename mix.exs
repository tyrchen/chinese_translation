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
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # exdocs
      # Docs
      name: "ChineseTranslation",
      source_url: "https://github.com/tyrchen/chinese_translation",
      homepage_url: "https://github.com/tyrchen/chinese_translation",
      docs: [
        main: "ChineseTranslation",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

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
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*", "version"],
      licenses: ["MIT"],
      maintainers: ["tyr.chen@gmail.com"],
      links: %{
        "GitHub" => "https://github.com/tyrchen/chinese_translation",
        "Docs" => "https://hexdocs.pm/chinese_translation"
      }
    ]
  end
end
