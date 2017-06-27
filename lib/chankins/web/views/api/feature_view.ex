defmodule Chankins.Web.API.FeatureView do
  use Chankins.Web, :view
  alias Chankins.Web.API.FeatureView

  def render("index.json", %{features: features}) do
    %{data: render_many(features, FeatureView, "feature.json")}
  end

  def render("show.json", %{feature: feature}) do
    %{data: render_one(feature, FeatureView, "feature.json")}
  end

  def render("feature.json", %{feature: feature}) do
    %{id: feature.id}
  end
end
