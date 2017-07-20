defmodule Phrampu.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :career_acc, :string
      add :name, :string
      add :email, :string
      add :machine, :string

      timestamps()
    end

  end
end
