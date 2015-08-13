defmodule MessageSystem.Mixfile do
  use Mix.Project

  def project do
    [app: :message_system,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger],
     mod: {MessageSystem, %{processor: processor(Mix.env)}}]
  end

  # Dependencies can be Hex packages:
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:jsx, "~> 2.7.0"}]
  end

  defp processor(:test), do: TestProcessor
  defp processor(_env),  do: MessageSystem.InboundProcessor
end

