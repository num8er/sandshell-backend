defmodule Sandshell.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    Code.require_file("lib/sandshell.ex")
    manifest = Sandshell.manifest()

    [
      name: manifest[:name],
      version: manifest[:version],
      type: :library,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  defp deps do
    [
      # database and pooling
      {:couchbeam, "~> 1.5.3"},
      {:poolboy, "~> 1.5.2"},

      # fixes issue in Couchbeam
      # https://github.com/benoitc/couchbeam/issues/200
      {:jsx, "2.8.3", override: true}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      setup: ["cmd mix setup"]
    ]
  end
end
