defmodule Chankins.Web.API.ProjectController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Project

  action_fallback Chankins.Web.FallbackController

  def index(conn, _params) do
    projects = ChangeManagement.list_projects()
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    with {:ok, %Project{} = project} <- ChangeManagement.create_project(project_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_project_path(conn, :show, project))
      |> render("show.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = ChangeManagement.get_project!(id)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = ChangeManagement.get_project!(id)

    with {:ok, %Project{} = project} <- ChangeManagement.update_project(project, project_params) do
      render(conn, "show.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = ChangeManagement.get_project!(id)
    with {:ok, %Project{}} <- ChangeManagement.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
