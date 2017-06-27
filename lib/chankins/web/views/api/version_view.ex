defmodule Chankins.Web.API.VersionView do
  use Chankins.Web, :view
  alias Chankins.Web.API.VersionView

  def render("index.json", %{versions: versions}) do
    %{data: render_many(versions, VersionView, "version.json")}
  end

  def render("show.json", %{version: version}) do
    %{data: render_one(version, VersionView, "version.json")}
  end

  def render("version.json", %{version: version}) do
    %{id: version.id}
  end
end
