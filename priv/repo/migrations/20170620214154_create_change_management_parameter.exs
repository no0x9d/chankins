defmodule Chankins.Repo.Migrations.CreateChankins.ChangeManagement.Parameter do
  use Ecto.Migration

  def change do
    create table(:change_management_parameters) do
      add :key, :string
      add :value, :string
      add :group, :string
      add :version_id, references(:change_management_versions, on_delete: :nothing)
      add :feature_id, references(:change_management_features, on_delete: :nothing)

      timestamps()
    end

    create index(:change_management_parameters, [:version_id])
    create index(:change_management_parameters, [:feature_id])
  end
end
