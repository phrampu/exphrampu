defmodule Phrampu.Mixfile do
  use Mix.Project

  def project do
    [app: :phrampu,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: 
      [:logger, :cowboy, :ranch, :nimble_csv, :quantum]]
  end

  defp deps do
    [{:sshex, "2.1.1"}, 
     { :cowboy, github: "ninenines/cowboy", tag: "2.0.0-pre.3" },
     {:poison, "~> 3.0"},
     {:nimble_csv, "~> 0.1.0"},
     {:quantum, ">= 1.9.0"},
     {:dogma, "~> 0.1", only: :dev}
    ]
  end
end
