defmodule Chankins.Repo.Migrations.CreateChankins.ChangeManagement.Feature do
  use Ecto.Migration

  def change do
    create table(:change_management_features) do
      add :title, :string
      add :description, :string
      add :version_id, references(:change_management_versions, on_delete: :nothing)

      timestamps()
    end

    create index(:change_management_features, [:version_id])
  end
end
