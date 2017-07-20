defmodule Phrampu.HostTest do
  use Phrampu.ModelCase

  alias Phrampu.Host

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Host.changeset(%Host{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Host.changeset(%Host{}, @invalid_attrs)
    refute changeset.valid?
  end
end
