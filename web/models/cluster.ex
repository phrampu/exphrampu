defmodule Phrampu.Cluster do
  use Phrampu.Web, :model
  import Ecto.Query

  schema "clusters" do
    field :name, :string
    field :room, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :room])
    |> validate_required([:name, :room])
  end
end
