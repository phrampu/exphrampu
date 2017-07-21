defmodule Phrampu.Host do
  use Phrampu.Web, :model

  schema "hosts" do
    field :name, :string
    belongs_to :cluster, Phrampu.Cluster

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :cluster_id])
    |> validate_required([:name, :cluster_id])
    |> assoc_constraint(:cluster)
  end
end
