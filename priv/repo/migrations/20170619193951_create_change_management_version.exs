defmodule Chankins.Repo.Migrations.CreateChankins.ChangeManagement.Version do
  use Ecto.Migration

  def change do
    create table(:change_management_versions) do
      add :version, :string
      add :release_date, :utc_datetime
      add :release_id, references(:change_management_releases, on_delete: :nothing)

      timestamps()
    end

    create index(:change_management_versions, [:release_id])
  end
end
