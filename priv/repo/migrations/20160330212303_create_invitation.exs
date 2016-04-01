defmodule Library.Repo.Migrations.CreateInvitation do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :email, :string

      timestamps
    end

  end
end
