defmodule Phrampu.Cluster do
  use Phrampu.Web, :model
  import Ecto.Query
  alias Phrampu.Host

  @derive {Poison.Encoder, only: 
    [:name, :room, :hosts]
  }
  schema "clusters" do
    field :name, :string
    field :room, :string
    has_many :hosts, {"hosts", Host}, on_delete: :delete_all

    timestamps()
  end

  def get_active_whos(query) do
    from c in query,
      join: h in assoc(c, :hosts),
      join: w in assoc(h, :whos),
      #w.is_tty and 
      where: not w.is_idle and w.updated_at >= type(^Phrampu.Who.mins_ago(20), Ecto.DateTime),
      preload: 
        [hosts: {h, 
            whos: {w, :student}}]
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
