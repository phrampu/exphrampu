defmodule HTTPHandler do
  @moduledoc """
  HTTP helper methods, including parsing data from Phrampu nodes into json
  """
  # TODO: Clean this up later, its still O(n) but really bad looking
  def cluster_count(map) do
    count_map = map
      |> Enum.map(fn({host, v}) -> {host, Enum.count(v)} end)

    total = count_map
      |> Enum.count()

    unavailable = count_map
      |> Enum.filter(fn({_host, num}) -> num == 1 end)
      |> Enum.count()

    user_list = map
      |> Enum.filter(fn({_host, v}) -> Enum.count(v) > 0 end)
      |> Enum.map(fn({_host, v}) -> hd(v).user end)

    users = map
      |> Enum.filter(fn({_host, v}) -> Enum.count(v) > 0 end)
      |> Enum.map(fn({_host, v}) -> hd(v) end)

    %{
      :unavailable => unavailable,
      :available => total - unavailable,
      :users => users,
      :userlist => user_list
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

  def terminate(_reason, _request, _state) do
    :ok
  end
end

defmodule HTTPModule do
  @moduledoc """
  HTTP Server functionality using Cowboy
  """
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
