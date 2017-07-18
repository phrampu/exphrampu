defmodule Phrampu.StudentTest do
  use Phrampu.ModelCase

  alias Phrampu.Student

  @valid_attrs %{career_acc: "some content", email: "some content", machine: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
