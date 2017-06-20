defmodule Chankins.Web.ParameterControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement

  @create_attrs %{group: "some group", key: "some key", value: "some value"}
  @update_attrs %{group: "some updated group", key: "some updated key", value: "some updated value"}
  @invalid_attrs %{group: nil, key: nil, value: nil}

  def fixture(:parameter) do
    {:ok, parameter} = ChangeManagement.create_parameter(@create_attrs)
    parameter
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, parameter_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Parameters"
  end

  test "renders form for new parameters", %{conn: conn} do
    conn = get conn, parameter_path(conn, :new)
    assert html_response(conn, 200) =~ "New Parameter"
  end

  test "creates parameter and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, parameter_path(conn, :create), parameter: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == parameter_path(conn, :show, id)

    conn = get conn, parameter_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Parameter"
  end

  test "does not create parameter and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, parameter_path(conn, :create), parameter: @invalid_attrs
    assert html_response(conn, 200) =~ "New Parameter"
  end

  test "renders form for editing chosen parameter", %{conn: conn} do
    parameter = fixture(:parameter)
    conn = get conn, parameter_path(conn, :edit, parameter)
    assert html_response(conn, 200) =~ "Edit Parameter"
  end

  test "updates chosen parameter and redirects when data is valid", %{conn: conn} do
    parameter = fixture(:parameter)
    conn = put conn, parameter_path(conn, :update, parameter), parameter: @update_attrs
    assert redirected_to(conn) == parameter_path(conn, :show, parameter)

    conn = get conn, parameter_path(conn, :show, parameter)
    assert html_response(conn, 200) =~ "some updated group"
  end

  test "does not update chosen parameter and renders errors when data is invalid", %{conn: conn} do
    parameter = fixture(:parameter)
    conn = put conn, parameter_path(conn, :update, parameter), parameter: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Parameter"
  end

  test "deletes chosen parameter", %{conn: conn} do
    parameter = fixture(:parameter)
    conn = delete conn, parameter_path(conn, :delete, parameter)
    assert redirected_to(conn) == parameter_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, parameter_path(conn, :show, parameter)
    end
  end
end
