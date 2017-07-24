defmodule Phrampu.Repo.Migrations.AddFromToWhos do
  use Ecto.Migration

  def change do
    alter table(:whos) do
      add :from, :string
    end
  end
end
