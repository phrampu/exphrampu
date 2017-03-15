NimbleCSV.define(CSV, separator: ":", escape: ~s("))

defmodule LName do
  @moduledoc """
  store with career account => user information
  """
  use GenServer

  # Client
  def create do
    case GenServer.whereis({:global, LName}) do
      nil -> start_link()
      pid -> {:error, :lname_already_started, pid}
    end
  end

  def start_link do
    table = :ets.new(:lname_lookup, [:ordered_set, :protected, :named_table])

    "lname.db"
    |> File.stream!
    |> CSV.parse_stream
    |> Enum.map(fn [careerAcc, name, email | _] ->
      :ets.insert(:lname_lookup, {careerAcc,
        %{name: name |> String.split(",") |> List.first(),
          email: email}
      })
    end)

    GenServer.start_link(__MODULE__, [table: table], name: {:global, LName})
  end

  def lookup(pid, careerAcc) do
    GenServer.call(pid, {:lookup, careerAcc})
  end

  # Server (callbacks)
  def init(:ok, [table: _table]) do
    {:ok}
  end

  def handle_call({:lookup, careerAcc}, _from, [table: table]) do
    resp = :ets.lookup(table, careerAcc)
    resp = case resp do
      [x] -> x
      [] -> nil
    end
    {:reply, resp, [table: table]}
  end
end
