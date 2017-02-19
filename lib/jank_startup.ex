defmodule Jank do
  defp ref(cluster) do
    {:global, {:cluster, cluster}} |> GenServer.whereis()
  end

  def update do
    spawn_link fn -> Phrampu.Constants.ssHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("sslab"), x) end) end

    spawn_link fn -> Phrampu.Constants.podHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("pod"), x) end) end

    spawn_link fn -> Phrampu.Constants.borgHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("borg"), x) end) end

    spawn_link fn -> Phrampu.Constants.xinuHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("xinu"), x) end) end

    spawn_link fn -> Phrampu.Constants.mooreHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("moore"), x) end) end

    spawn_link fn -> Phrampu.Constants.escherHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("escher"), x) end) end
  end

  def go do
    Phrampu.Server.Supervisor.start_link()
    Phrampu.Server.create("xinu", Phrampu.Constants.xinuHosts)
    Phrampu.Server.create("borg", Phrampu.Constants.borgHosts)
    Phrampu.Server.create("pod", Phrampu.Constants.podHosts)
    Phrampu.Server.create("moore", Phrampu.Constants.mooreHosts)
    Phrampu.Server.create("escher", Phrampu.Constants.escherHosts)
    Phrampu.Server.create("sslab", Phrampu.Constants.ssHosts)
    spawn_link fn -> HTTPModule.start end
    spawn_link fn -> Jank.update() end
  end
end
