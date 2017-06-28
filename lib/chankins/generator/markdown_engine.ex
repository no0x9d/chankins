defmodule Chankins.Generator.MarkdownEngine do
  @moduledoc """
  This Engine renders a file or binary input in markdown format to HTML
  """

  def render_file(file, assigns) do
    File.read!(file)
    |> render_content(assigns)
  end

  def render_content(input, _assigns) do
    Earmark.as_html!(input)
  end
end