defmodule Phrampu.ClusterController do
  use Phrampu.Web, :controller

  alias Phrampu.Cluster

  def index(conn, _params) do
    clusters = Repo.all(Cluster)
    render(conn, "index.html", clusters: clusters)
  end

  def new(conn, _params) do
    changeset = Cluster.changeset(%Cluster{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cluster" => cluster_params}) do
    changeset = Cluster.changeset(%Cluster{}, cluster_params)

    case Repo.insert(changeset) do
      {:ok, _cluster} ->
        conn
        |> put_flash(:info, "Cluster created successfully.")
        |> redirect(to: cluster_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cluster = Repo.get!(Cluster, id)
    render(conn, "show.html", cluster: cluster)
  end

  def edit(conn, %{"id" => id}) do
    cluster = Repo.get!(Cluster, id)
    changeset = Cluster.changeset(cluster)
    render(conn, "edit.html", cluster: cluster, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cluster" => cluster_params}) do
    cluster = Repo.get!(Cluster, id)
    changeset = Cluster.changeset(cluster, cluster_params)

    case Repo.update(changeset) do
      {:ok, cluster} ->
        conn
        |> put_flash(:info, "Cluster updated successfully.")
        |> redirect(to: cluster_path(conn, :show, cluster))
      {:error, changeset} ->
        render(conn, "edit.html", cluster: cluster, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cluster = Repo.get!(Cluster, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cluster)

    conn
    |> put_flash(:info, "Cluster deleted successfully.")
    |> redirect(to: cluster_path(conn, :index))
  end
end
