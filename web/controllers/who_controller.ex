defmodule Phrampu.WhoController do
  use Phrampu.Web, :controller

  alias Phrampu.Who

  def index(conn, _params) do
    whos = Repo.all(Who)
    render(conn, "index.html", whos: whos)
  end

  def new(conn, _params) do
    changeset = Who.changeset(%Who{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"who" => who_params}) do
    changeset = Who.changeset(%Who{}, who_params)

    case Repo.insert(changeset) do
      {:ok, _who} ->
        conn
        |> put_flash(:info, "Who created successfully.")
        |> redirect(to: who_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    who = Repo.get!(Who, id)
    render(conn, "show.html", who: who)
  end

  def edit(conn, %{"id" => id}) do
    who = Repo.get!(Who, id)
    changeset = Who.changeset(who)
    render(conn, "edit.html", who: who, changeset: changeset)
  end

  def update(conn, %{"id" => id, "who" => who_params}) do
    who = Repo.get!(Who, id)
    changeset = Who.changeset(who, who_params)

    case Repo.update(changeset) do
      {:ok, who} ->
        conn
        |> put_flash(:info, "Who updated successfully.")
        |> redirect(to: who_path(conn, :show, who))
      {:error, changeset} ->
        render(conn, "edit.html", who: who, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    who = Repo.get!(Who, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(who)

    conn
    |> put_flash(:info, "Who deleted successfully.")
    |> redirect(to: who_path(conn, :index))
  end
end
