defmodule Library.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :email, :string
      add :message, :string

      timestamps
    end

  end
end
