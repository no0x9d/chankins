defmodule :"Elixir.Chankins.Repo.Migrations.201707211545AlterReferenceToDeleteAll" do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE change_management_releases DROP CONSTRAINT change_management_releases_project_id_fkey"
    alter table(:change_management_releases) do
      modify :project_id, references(:change_management_projects, on_delete: :delete_all)
    end

    execute "ALTER TABLE change_management_parameters DROP CONSTRAINT change_management_parameters_version_id_fkey"
    execute "ALTER TABLE change_management_parameters DROP CONSTRAINT change_management_parameters_feature_id_fkey"
    alter table(:change_management_parameters) do
      modify :version_id, references(:change_management_versions, on_delete: :delete_all)
      modify :feature_id, references(:change_management_features, on_delete: :delete_all)
    end

    execute "ALTER TABLE change_management_versions DROP CONSTRAINT change_management_versions_release_id_fkey"
    alter table(:change_management_versions) do
      modify :release_id, references(:change_management_releases, on_delete: :delete_all)
    end

    execute "ALTER TABLE change_management_features DROP CONSTRAINT change_management_features_version_id_fkey"
    alter table(:change_management_features) do
      modify :version_id, references(:change_management_versions, on_delete: :delete_all)
    end
  end
end
