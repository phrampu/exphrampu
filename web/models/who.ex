defmodule Phrampu.Who do
  use Phrampu.Web, :model

  schema "whos" do
    field :is_tty, :boolean, default: false
    field :is_idle, :boolean, default: false
    field :tty, :string
    field :login, :string
    field :idle, :string
    field :jcpu, :string
    field :pcpu, :string
    field :what, :string
    belongs_to :host, Phrampu.Host
    belongs_to :student, Phrampu.Student

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:student_id, :host_id, :is_tty, :is_idle, :tty, :login, :idle, :jcpu, :pcpu, :what])
    |> validate_required([:student_id, :host_id, :is_tty, :is_idle, :tty, :login, :idle, :jcpu, :pcpu, :what])
    |> assoc_constraint(:host)
    |> assoc_constraint(:student)
  end
end
