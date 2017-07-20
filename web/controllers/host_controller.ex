defmodule Phrampu.HostController do
  use Phrampu.Web, :controller

  alias Phrampu.Host

  def index(conn, _params) do
    hosts = Repo.all(Host)
    render(conn, "index.html", hosts: hosts)
  end

  def new(conn, _params) do
    changeset = Host.changeset(%Host{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"host" => host_params}) do
    changeset = Host.changeset(%Host{}, host_params)

    case Repo.insert(changeset) do
      {:ok, _host} ->
        conn
        |> put_flash(:info, "Host created successfully.")
        |> redirect(to: host_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    host = Repo.get!(Host, id)
    render(conn, "show.html", host: host)
  end

  def edit(conn, %{"id" => id}) do
    host = Repo.get!(Host, id)
    changeset = Host.changeset(host)
    render(conn, "edit.html", host: host, changeset: changeset)
  end

  def update(conn, %{"id" => id, "host" => host_params}) do
    host = Repo.get!(Host, id)
    changeset = Host.changeset(host, host_params)

    case Repo.update(changeset) do
      {:ok, host} ->
        conn
        |> put_flash(:info, "Host updated successfully.")
        |> redirect(to: host_path(conn, :show, host))
      {:error, changeset} ->
        render(conn, "edit.html", host: host, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    host = Repo.get!(Host, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(host)

    conn
    |> put_flash(:info, "Host deleted successfully.")
    |> redirect(to: host_path(conn, :index))
  end
end
