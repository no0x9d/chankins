defmodule Chankins.Web.FeatureController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement

  def index(conn, _params) do
    features = ChangeManagement.list_features()
    render(conn, "index.html", features: features)
  end

  def new(conn, _params) do
    changeset = ChangeManagement.change_feature(%Chankins.ChangeManagement.Feature{})
    versions = ChangeManagement.list_versions()
    render(conn, "new.html", changeset: changeset, versions: versions)
  end

  def create(conn, %{"feature" => feature_params}) do
    case ChangeManagement.create_feature(feature_params) do
      {:ok, feature} ->
        conn
        |> put_flash(:info, "Feature created successfully.")
        |> redirect(to: feature_path(conn, :show, feature))
      {:error, %Ecto.Changeset{} = changeset} ->
        versions = ChangeManagement.list_versions()
        render(conn, "new.html", changeset: changeset, versions: versions)
    end
  end

  def show(conn, %{"id" => id}) do
    feature = ChangeManagement.get_feature!(id)
    render(conn, "show.html", feature: feature)
  end

  def edit(conn, %{"id" => id}) do
    feature = ChangeManagement.get_feature!(id)
    changeset = ChangeManagement.change_feature(feature)
    versions = ChangeManagement.list_versions()
    render(conn, "edit.html", changeset: changeset, feature: feature, versions: versions)
  end

  def update(conn, %{"id" => id, "feature" => feature_params}) do
    feature = ChangeManagement.get_feature!(id)

    case ChangeManagement.update_feature(feature, feature_params) do
      {:ok, feature} ->
        conn
        |> put_flash(:info, "Feature updated successfully.")
        |> redirect(to: feature_path(conn, :show, feature))
      {:error, %Ecto.Changeset{} = changeset} ->
        versions = ChangeManagement.list_versions()
        render(conn, "edit.html", changeset: changeset, feature: feature, versions: versions)
    end
  end

  def delete(conn, %{"id" => id}) do
    feature = ChangeManagement.get_feature!(id)
    {:ok, _feature} = ChangeManagement.delete_feature(feature)

    conn
    |> put_flash(:info, "Feature deleted successfully.")
    |> redirect(to: feature_path(conn, :index))
  end
end
