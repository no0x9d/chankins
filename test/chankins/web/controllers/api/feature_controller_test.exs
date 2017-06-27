defmodule Chankins.Web.API.FeatureControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Feature

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:feature) do
    {:ok, feature} = ChangeManagement.create_feature(@create_attrs)
    feature
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_feature_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates feature and renders feature when data is valid", %{conn: conn} do
    conn = post conn, api_feature_path(conn, :create), feature: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, api_feature_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not create feature and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_feature_path(conn, :create), feature: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen feature and renders feature when data is valid", %{conn: conn} do
    %Feature{id: id} = feature = fixture(:feature)
    conn = put conn, api_feature_path(conn, :update, feature), feature: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, api_feature_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not update chosen feature and renders errors when data is invalid", %{conn: conn} do
    feature = fixture(:feature)
    conn = put conn, api_feature_path(conn, :update, feature), feature: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen feature", %{conn: conn} do
    feature = fixture(:feature)
    conn = delete conn, api_feature_path(conn, :delete, feature)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, api_feature_path(conn, :show, feature)
    end
  end
end
