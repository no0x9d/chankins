defmodule Chankins.ChangeManagementTest do
  use Chankins.DataCase

  alias Chankins.ChangeManagement

  describe "projects" do
    alias Chankins.ChangeManagement.Project

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ChangeManagement.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert ChangeManagement.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert ChangeManagement.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = ChangeManagement.create_project(@valid_attrs)
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = ChangeManagement.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.update_project(project, @invalid_attrs)
      assert project == ChangeManagement.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = ChangeManagement.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> ChangeManagement.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = ChangeManagement.change_project(project)
    end
  end

  describe "releases" do
    alias Chankins.ChangeManagement.Release

    @valid_attrs %{version: "some version"}
    @update_attrs %{version: "some updated version"}
    @invalid_attrs %{version: nil}

    def release_fixture(attrs \\ %{}) do
      {:ok, release} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ChangeManagement.create_release()

      release
    end

    test "list_releases/0 returns all releases" do
      release = release_fixture()
      assert ChangeManagement.list_releases() == [release]
    end

    test "get_release!/1 returns the release with given id" do
      release = release_fixture()
      assert ChangeManagement.get_release!(release.id) == release
    end

    test "create_release/1 with valid data creates a release" do
      assert {:ok, %Release{} = release} = ChangeManagement.create_release(@valid_attrs)
      assert release.version == "some version"
    end

    test "create_release/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.create_release(@invalid_attrs)
    end

    test "update_release/2 with valid data updates the release" do
      release = release_fixture()
      assert {:ok, release} = ChangeManagement.update_release(release, @update_attrs)
      assert %Release{} = release
      assert release.version == "some updated version"
    end

    test "update_release/2 with invalid data returns error changeset" do
      release = release_fixture()
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.update_release(release, @invalid_attrs)
      assert release == ChangeManagement.get_release!(release.id)
    end

    test "delete_release/1 deletes the release" do
      release = release_fixture()
      assert {:ok, %Release{}} = ChangeManagement.delete_release(release)
      assert_raise Ecto.NoResultsError, fn -> ChangeManagement.get_release!(release.id) end
    end

    test "change_release/1 returns a release changeset" do
      release = release_fixture()
      assert %Ecto.Changeset{} = ChangeManagement.change_release(release)
    end
  end
end
