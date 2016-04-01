defmodule Library.Repo.Migrations.CreateLibrary do
  use Ecto.Migration

  def change do
    create table(:libraries) do
      add :name, :string
      add :address, :string
      add :phone, :string

      timestamps
    end

  end
end
