NimbleCSV.define(CSV, separator: ":", escape: "\"")

defmodule LName do
  @moduledoc """
  store with career account => user information
  """
  use GenServer

  # Client
  def start_link() do
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

    GenServer.start_link(__MODULE__, [table: table])
  end

  def state(pid, careerAcc) do
    GenServer.call(pid, {:lookup, careerAcc})
  end

  # Server (callbacks)
  def init(:ok, {table}) do
    {:ok}
  end

  def handle_call({:lookup, careerAcc}, _from, [table: table]) do
    resp = :ets.lookup(table, careerAcc)
    {:reply, resp, [table: table]}
  end
end
