defmodule Chankins.Web.API.ReleaseController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Release

  action_fallback Chankins.Web.FallbackController

  def index(conn, _params) do
    releases = ChangeManagement.list_releases()
    render(conn, "index.json", releases: releases)
  end

  def create(conn, %{"release" => release_params}) do
    with {:ok, %Release{} = release} <- ChangeManagement.create_release(release_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_release_path(conn, :show, release))
      |> render("show.json", release: release)
    end
  end

  def show(conn, %{"id" => id}) do
    release = ChangeManagement.get_release!(id)
    render(conn, "show.json", release: release)
  end

  def update(conn, %{"id" => id, "release" => release_params}) do
    release = ChangeManagement.get_release!(id)

    with {:ok, %Release{} = release} <- ChangeManagement.update_release(release, release_params) do
      render(conn, "show.json", release: release)
    end
  end

  def delete(conn, %{"id" => id}) do
    release = ChangeManagement.get_release!(id)
    with {:ok, %Release{}} <- ChangeManagement.delete_release(release) do
      send_resp(conn, :no_content, "")
    end
  end
end
