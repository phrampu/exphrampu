defmodule Phrampu.Repo.Migrations.CreateWho do
  use Ecto.Migration

  def change do
    create table(:whos) do
      add :is_tty, :boolean, default: false, null: false
      add :is_idle, :boolean, default: false, null: false
      add :tty, :string
      add :login, :string
      add :idle, :string
      add :jcpu, :string
      add :pcpu, :string
      add :what, :string
      add :host_id, references(:hosts, on_delete: :nothing)
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end
    create index(:whos, [:host_id])
    create index(:whos, [:student_id])

  end
end
