defmodule Chankins.Web.API.ParameterControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Parameter

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:parameter) do
    {:ok, parameter} = ChangeManagement.create_parameter(@create_attrs)
    parameter
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_parameter_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates parameter and renders parameter when data is valid", %{conn: conn} do
    conn = post conn, api_parameter_path(conn, :create), parameter: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, api_parameter_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not create parameter and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_parameter_path(conn, :create), parameter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen parameter and renders parameter when data is valid", %{conn: conn} do
    %Parameter{id: id} = parameter = fixture(:parameter)
    conn = put conn, api_parameter_path(conn, :update, parameter), parameter: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, api_parameter_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not update chosen parameter and renders errors when data is invalid", %{conn: conn} do
    parameter = fixture(:parameter)
    conn = put conn, api_parameter_path(conn, :update, parameter), parameter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen parameter", %{conn: conn} do
    parameter = fixture(:parameter)
    conn = delete conn, api_parameter_path(conn, :delete, parameter)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, api_parameter_path(conn, :show, parameter)
    end
  end
end
