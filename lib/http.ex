defmodule HTTPHandler do
  def init(request, state) do
    pidnum  = :cowboy_req.binding(:pidnum, request)

		api_result = Phrampu.state(pidnum)

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
      {"/phrampu/:pidnum", HTTPHandler, []},
    ]

		dispatch_config = :cowboy_router.compile([{ :_, routes}])

    opts = [{:port, 8080}]

    env = [dispatch: dispatch_config]

		{:ok, _} = :cowboy.start_http(:http, 100, opts, [env: env])
	end
end

