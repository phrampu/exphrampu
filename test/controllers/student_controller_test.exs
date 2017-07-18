defmodule Phrampu.StudentControllerTest do
  use Phrampu.ConnCase

  alias Phrampu.Student
  @valid_attrs %{career_acc: "some content", email: "some content", machine: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, student_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing students"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, student_path(conn, :new)
    assert html_response(conn, 200) =~ "New student"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, student_path(conn, :create), student: @valid_attrs
    assert redirected_to(conn) == student_path(conn, :index)
    assert Repo.get_by(Student, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, student_path(conn, :create), student: @invalid_attrs
    assert html_response(conn, 200) =~ "New student"
  end

  test "shows chosen resource", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = get conn, student_path(conn, :show, student)
    assert html_response(conn, 200) =~ "Show student"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, student_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = get conn, student_path(conn, :edit, student)
    assert html_response(conn, 200) =~ "Edit student"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = put conn, student_path(conn, :update, student), student: @valid_attrs
    assert redirected_to(conn) == student_path(conn, :show, student)
    assert Repo.get_by(Student, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = put conn, student_path(conn, :update, student), student: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit student"
  end

  test "deletes chosen resource", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = delete conn, student_path(conn, :delete, student)
    assert redirected_to(conn) == student_path(conn, :index)
    refute Repo.get(Student, student.id)
  end
end
