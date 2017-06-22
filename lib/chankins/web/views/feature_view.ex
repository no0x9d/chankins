defmodule Chankins.Web.FeatureView do
  use Chankins.Web, :view

    def map_versions_for_select(versions) do
      versions |> Enum.map(&map_version_for_select/1)
    end

    defp map_version_for_select(v) do
      {"#{v.version} (#{v.release.name})", v.id}
    end
end
