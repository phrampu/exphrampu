defmodule Phrampu.ClusterControllerTest do
  use Phrampu.ConnCase

  alias Phrampu.Cluster
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cluster_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing clusters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cluster_path(conn, :new)
    assert html_response(conn, 200) =~ "New cluster"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, cluster_path(conn, :create), cluster: @valid_attrs
    assert redirected_to(conn) == cluster_path(conn, :index)
    assert Repo.get_by(Cluster, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cluster_path(conn, :create), cluster: @invalid_attrs
    assert html_response(conn, 200) =~ "New cluster"
  end

  test "shows chosen resource", %{conn: conn} do
    cluster = Repo.insert! %Cluster{}
    conn = get conn, cluster_path(conn, :show, cluster)
    assert html_response(conn, 200) =~ "Show cluster"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, cluster_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cluster = Repo.insert! %Cluster{}
    conn = get conn, cluster_path(conn, :edit, cluster)
    assert html_response(conn, 200) =~ "Edit cluster"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cluster = Repo.insert! %Cluster{}
    conn = put conn, cluster_path(conn, :update, cluster), cluster: @valid_attrs
    assert redirected_to(conn) == cluster_path(conn, :show, cluster)
    assert Repo.get_by(Cluster, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cluster = Repo.insert! %Cluster{}
    conn = put conn, cluster_path(conn, :update, cluster), cluster: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cluster"
  end

  test "deletes chosen resource", %{conn: conn} do
    cluster = Repo.insert! %Cluster{}
    conn = delete conn, cluster_path(conn, :delete, cluster)
    assert redirected_to(conn) == cluster_path(conn, :index)
    refute Repo.get(Cluster, cluster.id)
  end
end
