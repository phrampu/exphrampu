defmodule Phrampu.WhoControllerTest do
  use Phrampu.ConnCase

  alias Phrampu.Who
  @valid_attrs %{idle: "some content", is_tty: true, jcpu: "some content", login: "some content", pcpu: "some content", tty: "some content", what: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, who_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing whos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, who_path(conn, :new)
    assert html_response(conn, 200) =~ "New who"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, who_path(conn, :create), who: @valid_attrs
    assert redirected_to(conn) == who_path(conn, :index)
    assert Repo.get_by(Who, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, who_path(conn, :create), who: @invalid_attrs
    assert html_response(conn, 200) =~ "New who"
  end

  test "shows chosen resource", %{conn: conn} do
    who = Repo.insert! %Who{}
    conn = get conn, who_path(conn, :show, who)
    assert html_response(conn, 200) =~ "Show who"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, who_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    who = Repo.insert! %Who{}
    conn = get conn, who_path(conn, :edit, who)
    assert html_response(conn, 200) =~ "Edit who"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    who = Repo.insert! %Who{}
    conn = put conn, who_path(conn, :update, who), who: @valid_attrs
    assert redirected_to(conn) == who_path(conn, :show, who)
    assert Repo.get_by(Who, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    who = Repo.insert! %Who{}
    conn = put conn, who_path(conn, :update, who), who: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit who"
  end

  test "deletes chosen resource", %{conn: conn} do
    who = Repo.insert! %Who{}
    conn = delete conn, who_path(conn, :delete, who)
    assert redirected_to(conn) == who_path(conn, :index)
    refute Repo.get(Who, who.id)
  end
end
