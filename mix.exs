defmodule Fcmex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fcmex,
      version: "0.6.4",
      elixir: "~> 1.13",
      description: description(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ],
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  def application do
    [extra_applications: [:logger, :retry]]
  end

  defp description do
    """
    A Firebase Cloud Message client for Elixir
    """
  end

  defp deps do
    [
      {:httpoison, ">= 0.0.0"},
      {:poison, ">= 0.0.0"},
      {:flow, "~> 1.2.0"},
      {:retry, "~> 0.18.0"},
      {:credo, "~> 1.3", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:exvcr, ">= 0.0.0", only: [:test, :dev]},
      {:excoveralls, "~> 0.14 and >= 0.14.4", only: [:dev, :test]},
      {:joken, "~> 2.5.0"},
      {:jose, "1.11.6", override: true}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Shuhei Hayashibara"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/shufo/fcmex",
        "Docs" => "https://hexdocs.pm/fcmex"
      }
    ]
  end
end
