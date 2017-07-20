defmodule Phrampu.Repo.Migrations.CreateHost do
  use Ecto.Migration

  def change do
    create table(:hosts) do
      add :name, :string
      add :cluster_id, references(:clusters, on_delete: :nothing)

      timestamps()
    end
    create index(:hosts, [:cluster_id])

  end
end
