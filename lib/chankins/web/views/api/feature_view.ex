defmodule Chankins.Web.API.FeatureView do
  use Chankins.Web, :view
  alias Chankins.Web.API.{FeatureView, ParameterView}

  def render("index.json", %{features: features}) do
    %{data: render_many(features, FeatureView, "feature.json")}
  end

  def render("show.json", %{feature: feature}) do
    %{data: render_one(feature, FeatureView, "full_feature.json")}
  end

  def render("feature.json", %{feature: feature}) do
    %{id: feature.id, title: feature.title, description: feature.description}
  end

  def render("full_feature.json", %{feature: feature}) do
    %{
      id: feature.id,
      title: feature.title,
      description: feature.description,
      parameters: render_many(feature.parameters, ParameterView, "parameter.json")
    }
  end
end
