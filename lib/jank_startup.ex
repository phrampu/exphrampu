defmodule Jank do
  @moduledoc """
    Run Jank.go to start the web server + start the Phrampu nodes.
    I need to find a better way to do this.
  """
  defp clusterMap do
    %{
      "sslab" => Phrampu.Constants.ss_hosts,
      "pod" => Phrampu.Constants.pod_hosts,
      "borg" => Phrampu.Constants.borg_hosts,
      "xinu" => Phrampu.Constants.xinu_hosts,
      "moore" => Phrampu.Constants.moore_hosts,
      "escher" => Phrampu.Constants.escher_hosts,
    }
  end

  def update(cluster, urls) do
    spawn_link fn -> urls
      |> Enum.each(fn(x) ->
        pid = Phrampu.Server.refpid(cluster)
        IO.inspect pid 
        Phrampu.Server.who(pid, x) 
      end)
    end
  end

  def update_all do
    clusterMap() |> Enum.each(fn({cluster, urls}) ->
      update(cluster, urls)
    end)
  end

  def create(cluster, urls) do
    Phrampu.Server.create(cluster, urls)
  end

  def create_all do
    clusterMap() |> Enum.each(fn({cluster, urls}) ->
      create(cluster, urls)
    end)
  end

  def go do
    Phrampu.Server.Supervisor.start_link()
    create_all()
    spawn_link fn -> HTTPModule.start end
    # spawn_link fn -> Jank.update_all() end
  end
end
