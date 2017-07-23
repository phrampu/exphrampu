defmodule Phrampu.Who do
  use Phrampu.Web, :model

  @derive {Poison.Encoder, only: 
    [:host, :student, :login, :idle, :from, :jcpu, :pcpu, :what, :inserted_at, :updated_at]
  }
  schema "whos" do
    field :is_tty, :boolean, default: false
    field :is_idle, :boolean, default: false
    field :tty, :string
    field :login, :string
    field :from, :string
    field :idle, :string
    field :jcpu, :string
    field :pcpu, :string
    field :what, :string
    belongs_to :host, Phrampu.Host
    belongs_to :student, Phrampu.Student

    timestamps()
  end

  def not_idle(query) do
    query 
      |> where([w], w.is_idle == false)
  end

  def is_tty(query) do
    query 
      |> where([w], w.is_tty == true)
  end

  def mins_ago(mins) do
    :erlang.universaltime
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.-(mins * 60)
    |> :calendar.gregorian_seconds_to_datetime
    |> Ecto.DateTime.cast!
  end

  def is_recent(query) do
    query
      |> where([w], w.updated_at >= type(^mins_ago(20), Ecto.DateTime))
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:student_id, :host_id, :is_tty, :is_idle, :tty, :login, :from, :idle, :jcpu, :pcpu, :what])
    |> validate_required([:student_id, :host_id, :is_tty, :is_idle, :tty, :login, :from, :idle, :jcpu, :pcpu, :what])
    |> assoc_constraint(:host)
    |> assoc_constraint(:student)
  end
end
