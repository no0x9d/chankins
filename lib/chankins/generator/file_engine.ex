defmodule Chankins.Generator.FileEngine do
  @moduledoc false

  @doc """
    reads a file and returns the content unmodified
  """
  def render_file(file, _assigns) do
    File.read!(file)
  end

  @doc """
    returns the content without further modifications

    iex> render_content("foo", []) == "foo"
  """
  def render_content(content, _assigns) do
    content
  end
  
end