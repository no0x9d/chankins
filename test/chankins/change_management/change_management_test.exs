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

  describe "versions" do
    alias Chankins.ChangeManagement.Version

    @valid_attrs %{release_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, version: "some version"}
    @update_attrs %{release_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, version: "some updated version"}
    @invalid_attrs %{release_date: nil, version: nil}

    def version_fixture(attrs \\ %{}) do
      {:ok, version} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ChangeManagement.create_version()

      version
    end

    test "list_versions/0 returns all versions" do
      version = version_fixture()
      assert ChangeManagement.list_versions() == [version]
    end

    test "get_version!/1 returns the version with given id" do
      version = version_fixture()
      assert ChangeManagement.get_version!(version.id) == version
    end

    test "create_version/1 with valid data creates a version" do
      assert {:ok, %Version{} = version} = ChangeManagement.create_version(@valid_attrs)
      assert version.release_date == %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}
      assert version.version == "some version"
    end

    test "create_version/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.create_version(@invalid_attrs)
    end

    test "update_version/2 with valid data updates the version" do
      version = version_fixture()
      assert {:ok, version} = ChangeManagement.update_version(version, @update_attrs)
      assert %Version{} = version
      assert version.release_date == %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}
      assert version.version == "some updated version"
    end

    test "update_version/2 with invalid data returns error changeset" do
      version = version_fixture()
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.update_version(version, @invalid_attrs)
      assert version == ChangeManagement.get_version!(version.id)
    end

    test "delete_version/1 deletes the version" do
      version = version_fixture()
      assert {:ok, %Version{}} = ChangeManagement.delete_version(version)
      assert_raise Ecto.NoResultsError, fn -> ChangeManagement.get_version!(version.id) end
    end

    test "change_version/1 returns a version changeset" do
      version = version_fixture()
      assert %Ecto.Changeset{} = ChangeManagement.change_version(version)
    end
  end

  describe "features" do
    alias Chankins.ChangeManagement.Feature

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def feature_fixture(attrs \\ %{}) do
      {:ok, feature} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ChangeManagement.create_feature()

      feature
    end

    test "list_features/0 returns all features" do
      feature = feature_fixture()
      assert ChangeManagement.list_features() == [feature]
    end

    test "get_feature!/1 returns the feature with given id" do
      feature = feature_fixture()
      assert ChangeManagement.get_feature!(feature.id) == feature
    end

    test "create_feature/1 with valid data creates a feature" do
      assert {:ok, %Feature{} = feature} = ChangeManagement.create_feature(@valid_attrs)
      assert feature.description == "some description"
      assert feature.title == "some title"
    end

    test "create_feature/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.create_feature(@invalid_attrs)
    end

    test "update_feature/2 with valid data updates the feature" do
      feature = feature_fixture()
      assert {:ok, feature} = ChangeManagement.update_feature(feature, @update_attrs)
      assert %Feature{} = feature
      assert feature.description == "some updated description"
      assert feature.title == "some updated title"
    end

    test "update_feature/2 with invalid data returns error changeset" do
      feature = feature_fixture()
      assert {:error, %Ecto.Changeset{}} = ChangeManagement.update_feature(feature, @invalid_attrs)
      assert feature == ChangeManagement.get_feature!(feature.id)
    end

    test "delete_feature/1 deletes the feature" do
      feature = feature_fixture()
      assert {:ok, %Feature{}} = ChangeManagement.delete_feature(feature)
      assert_raise Ecto.NoResultsError, fn -> ChangeManagement.get_feature!(feature.id) end
    end

    test "change_feature/1 returns a feature changeset" do
      feature = feature_fixture()
      assert %Ecto.Changeset{} = ChangeManagement.change_feature(feature)
    end
  end
end
