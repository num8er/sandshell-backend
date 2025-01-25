defmodule SandshellBackend.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.0.2",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  defp deps do
    [
      # linter
      {:credo, "~> 1.7"},
    ]
  end

  defp elixirc_paths(:test), do: []
  defp elixirc_paths(_), do: []

  defp aliases do
    [
      setup: ["cmd mix setup"]
    ]
  end
end
