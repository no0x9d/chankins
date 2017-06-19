defmodule Chankins.Web.ReleaseController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement

  def index(conn, _params) do
    releases = ChangeManagement.list_releases()
    render(conn, "index.html", releases: releases)
  end

  def new(conn, _params) do
    changeset = ChangeManagement.change_release(%Chankins.ChangeManagement.Release{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"release" => release_params}) do
    case ChangeManagement.create_release(release_params) do
      {:ok, release} ->
        conn
        |> put_flash(:info, "Release created successfully.")
        |> redirect(to: release_path(conn, :show, release))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    release = ChangeManagement.get_release!(id)
    render(conn, "show.html", release: release)
  end

  def edit(conn, %{"id" => id}) do
    release = ChangeManagement.get_release!(id)
    changeset = ChangeManagement.change_release(release)
    render(conn, "edit.html", release: release, changeset: changeset)
  end

  def update(conn, %{"id" => id, "release" => release_params}) do
    release = ChangeManagement.get_release!(id)

    case ChangeManagement.update_release(release, release_params) do
      {:ok, release} ->
        conn
        |> put_flash(:info, "Release updated successfully.")
        |> redirect(to: release_path(conn, :show, release))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", release: release, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    release = ChangeManagement.get_release!(id)
    {:ok, _release} = ChangeManagement.delete_release(release)

    conn
    |> put_flash(:info, "Release deleted successfully.")
    |> redirect(to: release_path(conn, :index))
  end
end
