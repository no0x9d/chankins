defmodule Chankins.Repo.Migrations.CreateChankins.ChangeManagement.Release do
  use Ecto.Migration

  def change do
    create table(:change_management_releases) do
      add :version, :string
      add :project_id, references(:change_management_projects, on_delete: :nothing)

      timestamps()
    end

    create index(:change_management_releases, [:project_id])
  end
end
