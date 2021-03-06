defmodule Chankins.Web.API.ProjectView do
  use Chankins.Web, :view
  alias Chankins.Web.API.ProjectView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id, name: project.name, releases: render_many(project.releases, ProjectView, "release", as: :release)}
  end

  def render("release", %{release: release}) do
    %{id: release.id, name: release.name}
  end
end
