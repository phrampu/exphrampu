defmodule Phrampu.HostControllerTest do
  use Phrampu.ConnCase

  alias Phrampu.Host
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, host_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing hosts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, host_path(conn, :new)
    assert html_response(conn, 200) =~ "New host"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, host_path(conn, :create), host: @valid_attrs
    assert redirected_to(conn) == host_path(conn, :index)
    assert Repo.get_by(Host, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, host_path(conn, :create), host: @invalid_attrs
    assert html_response(conn, 200) =~ "New host"
  end

  test "shows chosen resource", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = get conn, host_path(conn, :show, host)
    assert html_response(conn, 200) =~ "Show host"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, host_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = get conn, host_path(conn, :edit, host)
    assert html_response(conn, 200) =~ "Edit host"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = put conn, host_path(conn, :update, host), host: @valid_attrs
    assert redirected_to(conn) == host_path(conn, :show, host)
    assert Repo.get_by(Host, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = put conn, host_path(conn, :update, host), host: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit host"
  end

  test "deletes chosen resource", %{conn: conn} do
    host = Repo.insert! %Host{}
    conn = delete conn, host_path(conn, :delete, host)
    assert redirected_to(conn) == host_path(conn, :index)
    refute Repo.get(Host, host.id)
  end
end
