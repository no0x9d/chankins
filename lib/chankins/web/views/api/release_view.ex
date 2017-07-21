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
    %{id: release.id, name: release.name, versions: render_many(release.versions, ReleaseView, "version", as: :version)}
  end

  def render("version", %{version: version}) do
    %{id: version.id, version: version.version}
  end
end
