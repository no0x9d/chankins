defmodule Chankins.Web.ChangeNotesController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement
  alias Chankins.Generator

  def show(conn, %{"version" => id}) do
    version = ChangeManagement.get_version_full_preload!(id)

    #get project configuration (template)
    response = version.project.id
    |> get_template_for_project_id
    |> Generator.generate(assigns: [version: version])

    html(conn, response)
  end

  defp get_template_for_project_id (project_id)do
    Application.get_env(:chankins, Chankins.Generator.Templates)
    |> Keyword.get(:projects, [])
    |> Map.fetch!(project_id)
  end

end