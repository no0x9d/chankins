defmodule Chankins.Web.FeatureControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:feature) do
    {:ok, feature} = ChangeManagement.create_feature(@create_attrs)
    feature
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feature_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Features"
  end

  test "renders form for new features", %{conn: conn} do
    conn = get conn, feature_path(conn, :new)
    assert html_response(conn, 200) =~ "New Feature"
  end

  test "creates feature and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, feature_path(conn, :create), feature: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == feature_path(conn, :show, id)

    conn = get conn, feature_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Feature"
  end

  test "does not create feature and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feature_path(conn, :create), feature: @invalid_attrs
    assert html_response(conn, 200) =~ "New Feature"
  end

  test "renders form for editing chosen feature", %{conn: conn} do
    feature = fixture(:feature)
    conn = get conn, feature_path(conn, :edit, feature)
    assert html_response(conn, 200) =~ "Edit Feature"
  end

  test "updates chosen feature and redirects when data is valid", %{conn: conn} do
    feature = fixture(:feature)
    conn = put conn, feature_path(conn, :update, feature), feature: @update_attrs
    assert redirected_to(conn) == feature_path(conn, :show, feature)

    conn = get conn, feature_path(conn, :show, feature)
    assert html_response(conn, 200) =~ "some updated description"
  end

  test "does not update chosen feature and renders errors when data is invalid", %{conn: conn} do
    feature = fixture(:feature)
    conn = put conn, feature_path(conn, :update, feature), feature: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Feature"
  end

  test "deletes chosen feature", %{conn: conn} do
    feature = fixture(:feature)
    conn = delete conn, feature_path(conn, :delete, feature)
    assert redirected_to(conn) == feature_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, feature_path(conn, :show, feature)
    end
  end
end
