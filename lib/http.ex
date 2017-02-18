defmodule HTTPHandler do
	def cluster_count(map) do
		count_map = map |> Enum.map(fn({host, v}) -> {host, Enum.count(v)} end) 
		total = count_map |> Enum.count()
		unavailable = count_map |> Enum.filter(fn({host, num}) -> num == 1 end) |> Enum.count()
		%{
			:unavailable => unavailable,
			:available => total - unavailable 
		}
	end

  def init(request, state) do
    sup = Process.whereis(Phrampu.Server.Supervisor)

    pids = case Supervisor.which_children(sup) do
      {:error, _ } -> []
      x -> x |> Enum.map(fn x -> elem(x, 1) end)
    end

    api_result = pids
      |> Enum.map(fn(pid) -> Phrampu.Server.state(pid) end)

    api_result = case api_result do
      [] -> [%{}]
      x -> x
    end

    api_result = api_result
      |> Enum.map(fn(m) -> %{m[:cluster] => cluster_count(m[:map])} end)
      |> Enum.reduce(fn(m, acc) -> Map.merge(m, acc) end)

    request = :cowboy_req.reply( 
      200,
      [ {"content-type", "application/json"} ],
      Poison.encode!(api_result),
      request
    )

    {:ok, request, state}
  end

  def terminate(reason, request, state) do
    :ok
  end
end

defmodule HTTPModule do

  def start do
    routes = [
      {"/", :cowboy_static, {:priv_file, :phrampu, "index.html"}},
      {"/phrampu", HTTPHandler, []},
    ]

    dispatch_config = :cowboy_router.compile([{ :_, routes}])

    opts = [{:port, 8080}]

    env = [dispatch: dispatch_config]

    {:ok, _} = :cowboy.start_http(:http, 100, opts, [env: env])
  end
end

