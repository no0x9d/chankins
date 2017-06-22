defmodule Chankins.Web.ParameterView do
  use Chankins.Web, :view

  def map_versions_for_select(versions) do
    versions |> Enum.map(&map_version_for_select/1) |> List.insert_at(0, {"leer", :nil})
  end

  defp map_version_for_select(v) do
    {"#{v.version} (#{v.release.name})", v.id}
  end

  def map_features_for_select(versions) do
    versions |> Enum.map(&map_feature_for_select/1)|> List.insert_at(0, {"leer", :nil})
  end

  defp map_feature_for_select(f) do
    {"#{f.title}", f.id}
  end
end
