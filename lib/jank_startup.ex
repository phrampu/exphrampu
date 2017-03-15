defmodule Jank do
  @moduledoc """
    Run Jank.go to start the web server + start the Phrampu nodes.
    I need to find a better way to do this.
  """
  defp ref(cluster) do
    {:global, {:cluster, cluster}} |> GenServer.whereis()
  end

  def update do
    spawn_link fn -> Phrampu.Constants.ss_hosts
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("sslab"), x) end) end

    spawn_link fn -> Phrampu.Constants.pod_hosts
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("pod"), x) end) end

    spawn_link fn -> Phrampu.Constants.borg_hosts
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("borg"), x) end) end

    spawn_link fn -> Phrampu.Constants.xinu_hosts
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("xinu"), x) end) end

    spawn_link fn -> Phrampu.Constants.moore_hosts
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("moore"), x) end) end

    spawn_link fn -> Phrampu.Constants.escher_hosts
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("escher"), x) end) end
  end

  def go do
    Phrampu.Server.Supervisor.start_link()
    Phrampu.Server.create("xinu", Phrampu.Constants.xinu_hosts)
    Phrampu.Server.create("borg", Phrampu.Constants.borg_hosts)
    Phrampu.Server.create("pod", Phrampu.Constants.pod_hosts)
    Phrampu.Server.create("moore", Phrampu.Constants.moore_hosts)
    Phrampu.Server.create("escher", Phrampu.Constants.escher_hosts)
    Phrampu.Server.create("sslab", Phrampu.Constants.ss_hosts)
    spawn_link fn -> HTTPModule.start end
    spawn_link fn -> Jank.update() end
  end
end
