defmodule Chankins.Web.API.VersionView do
  use Chankins.Web, :view
  alias Chankins.Web.API.{VersionView, ParameterView, FeatureView}

  def render("index.json", %{versions: versions}) do
    %{data: render_many(versions, VersionView, "version.json")}
  end

  def render("show.json", %{version: version}) do
    %{data: render_one(version, VersionView, "full_version.json")}
  end

  def render("version.json", %{version: version}) do
    %{
      id: version.id,
      release_date: version.release_date
    }
  end

  def render("full_version.json", %{version: version}) do
    %{
        id: version.id,
        release_date: version.release_date,
        parameters: render_many(version.parameters, ParameterView, "parameter.json"),
        features: render_many(version.features, FeatureView, "feature.json") }
  end
end
