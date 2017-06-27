defmodule Chankins.Web.API.ReleaseView do
  use Chankins.Web, :view
  alias Chankins.Web.API.ReleaseView

  def render("index.json", %{releases: releases}) do
    %{data: render_many(releases, ReleaseView, "release.json")}
  end

  def render("show.json", %{release: release}) do
    %{data: render_one(release, ReleaseView, "release.json")}
  end

  def render("release.json", %{release: release}) do
    %{id: release.id, versions: Enum.map(release.versions, &(&1).id)}
  end
end
