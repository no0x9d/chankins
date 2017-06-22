defmodule Chankins.Web.VersionController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement

  def index(conn, _params) do
    versions = ChangeManagement.list_versions()
    render(conn, "index.html", versions: versions)
  end

  def new(conn, _params) do
    changeset = ChangeManagement.change_version(%Chankins.ChangeManagement.Version{})
    releases = ChangeManagement.list_releases()
    render(conn, "new.html", changeset: changeset,  releases: releases)
  end

  def create(conn, %{"version" => version_params}) do
    case ChangeManagement.create_version(version_params) do
      {:ok, version} ->
        conn
        |> put_flash(:info, "Version created successfully.")
        |> redirect(to: version_path(conn, :show, version))
      {:error, %Ecto.Changeset{} = changeset} ->
        releases = ChangeManagement.list_releases()
        render(conn, "new.html", changeset: changeset,  releases: releases)
    end
  end

  def show(conn, %{"id" => id}) do
    version = ChangeManagement.get_version!(id)
    render(conn, "show.html", version: version)
  end

  def edit(conn, %{"id" => id}) do
    version = ChangeManagement.get_version!(id)
    changeset = ChangeManagement.change_version(version)
    releases = ChangeManagement.list_releases()
    render(conn, "edit.html", version: version, changeset: changeset, releases: releases)
  end

  def update(conn, %{"id" => id, "version" => version_params}) do
    version = ChangeManagement.get_version!(id)

    case ChangeManagement.update_version(version, version_params) do
      {:ok, version} ->
        conn
        |> put_flash(:info, "Version updated successfully.")
        |> redirect(to: version_path(conn, :show, version))
      {:error, %Ecto.Changeset{} = changeset} ->
        releases = ChangeManagement.list_releases()
        render(conn, "edit.html", version: version, changeset: changeset, releases: releases)
    end
  end

  def delete(conn, %{"id" => id}) do
    version = ChangeManagement.get_version!(id)
    {:ok, _version} = ChangeManagement.delete_version(version)

    conn
    |> put_flash(:info, "Version deleted successfully.")
    |> redirect(to: version_path(conn, :index))
  end
end
