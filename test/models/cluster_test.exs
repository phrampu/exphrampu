defmodule Phrampu.ClusterTest do
  use Phrampu.ModelCase

  alias Phrampu.Cluster

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cluster.changeset(%Cluster{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cluster.changeset(%Cluster{}, @invalid_attrs)
    refute changeset.valid?
  end
end
