defmodule Chankins.Repo.Migrations.RenameReleaseVersionColumn do
  use Ecto.Migration

  def change do
    rename table(:change_management_releases), :version, to: :name
  end
end
