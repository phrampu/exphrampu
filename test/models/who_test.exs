defmodule Phrampu.WhoTest do
  use Phrampu.ModelCase

  alias Phrampu.Who

  @valid_attrs %{idle: "some content", is_tty: true, jcpu: "some content", login: "some content", pcpu: "some content", tty: "some content", what: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Who.changeset(%Who{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Who.changeset(%Who{}, @invalid_attrs)
    refute changeset.valid?
  end
end
