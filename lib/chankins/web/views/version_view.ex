defmodule Chankins.Web.VersionView do
  use Chankins.Web, :view

  def map_releases_for_select(releases) do
    releases |> Enum.map(&map_release_for_select/1)
  end

  defp map_release_for_select(r) do
    {"#{r.name} (#{r.project.name})", r.id}
  end
end
