defmodule Chankins.Repo.Migrations.CreateChankins.ChangeManagement.Project do
  use Ecto.Migration

  def change do
    create table(:change_management_projects) do
      add :name, :string

      timestamps()
    end

  end
end
