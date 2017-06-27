defmodule Chankins.Web.API.VersionController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Version

  action_fallback Chankins.Web.FallbackController

  def index(conn, _params) do
    versions = ChangeManagement.list_versions()
    render(conn, "index.json", versions: versions)
  end

  def create(conn, %{"version" => version_params}) do
    with {:ok, %Version{} = version} <- ChangeManagement.create_version(version_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_version_path(conn, :show, version))
      |> render("show.json", version: version)
    end
  end

  def show(conn, %{"id" => id}) do
    version = ChangeManagement.get_version!(id)
    render(conn, "show.json", version: version)
  end

  def update(conn, %{"id" => id, "version" => version_params}) do
    version = ChangeManagement.get_version!(id)

    with {:ok, %Version{} = version} <- ChangeManagement.update_version(version, version_params) do
      render(conn, "show.json", version: version)
    end
  end

  def delete(conn, %{"id" => id}) do
    version = ChangeManagement.get_version!(id)
    with {:ok, %Version{}} <- ChangeManagement.delete_version(version) do
      send_resp(conn, :no_content, "")
    end
  end
end
