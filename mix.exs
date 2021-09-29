defmodule FtxLendingBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :ftx_lending_bot,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FtxLendingBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_ftx, github: "COLDTURNIP/ex_ftx", branch: "dev-lending-bot"},
      {:quantum, "~> 3.0"},
      {:vapor, "~> 0.10"}
    ]
  end
end
