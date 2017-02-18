defmodule Jank do
  defp ref(cluster) do
    {:global, {:cluster, cluster}} |> GenServer.whereis()
  end

  def update do
    Phrampu.Constants.podHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("pod"), x) end)

    Phrampu.Constants.borgHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("borg"), x) end)

    Phrampu.Constants.xinuHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("xinu"), x) end)

    Phrampu.Constants.mooreHosts 
      |> Enum.each(fn(x) -> Phrampu.Server.who(ref("moore"), x) end)

  end

  def go do
    sup = Phrampu.Server.Supervisor.start_link()
    Phrampu.Server.create("xinu", Phrampu.Constants.xinuHosts)
    Phrampu.Server.create("borg", Phrampu.Constants.borgHosts)
    Phrampu.Server.create("pod", Phrampu.Constants.podHosts)
    Phrampu.Server.create("moore", Phrampu.Constants.mooreHosts)
    spawn_link fn -> HTTPModule.start end
    spawn_link fn -> Jank.update() end
  end
end
