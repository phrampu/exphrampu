defmodule Phrampu.Student do
  use Phrampu.Web, :model

  @derive {Poison.Encoder, only: 
    [:career_acc, :name, :email]
  }
  schema "students" do
    field :career_acc, :string
    field :name, :string
    field :email, :string
    field :machine, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:career_acc, :name, :email, :machine])
    |> validate_required([:career_acc, :name, :email])
  end
end
