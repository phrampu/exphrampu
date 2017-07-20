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
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
